import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../Core/Errors/exception.dart';
import '../../../../core/Errors/failures.dart';
import '../../../../core/Network/network_connection_checker.dart';
import '../../Domain/Entites/auth_entity.dart';
import '../../Domain/Repositories/auth_repository.dart';
import '../DataSources/auth_local_data_source.dart';
import '../DataSources/auth_remote_data_source.dart';
import '../Models/auth_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDataSource authLocalDataSource;
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkConnectionChecker networkConnectionChecker;

  AuthRepositoryImpl(
      {required this.authLocalDataSource,
      required this.authRemoteDataSource,
      required this.networkConnectionChecker});

  @override
  Future<Either<Failure, Unit>> createAccount(AuthEntity authEntity) async {
    if (await networkConnectionChecker.isConnected) {
      try {
        AuthModel authModel = AuthModel(
            userName: authEntity.userName ?? '',
            email: authEntity.email,
            password: authEntity.password ?? '',
            phone: authEntity.phone ?? '');

        await authRemoteDataSource.createAccount(authModel);

        await authRemoteDataSource.setUserData(authModel);
        await authLocalDataSource.setUserData(authModel);
        await authLocalDataSource.setIsUserLoggedIn(isUserLoggedIn: true);

        return const Right(unit);
      } on WeakPasswordException {
        return Left(WeakPasswordFailure());
      } on EmailAlreadyInUseException {
        return Left(EmailAlreadyInUseFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> emailAndPasswordLogIn(
      AuthEntity authEntity) async {
    if (await networkConnectionChecker.isConnected) {
      try {
        AuthModel authModel = AuthModel(
            userName: authEntity.userName ?? '',
            email: authEntity.email,
            password: authEntity.password ?? '',
            phone: authEntity.phone ?? '');

        await authRemoteDataSource
            .emailAndPasswordLogIn(authModel)
            .then((value) async {
          await authLocalDataSource.setUserData(authModel);
          await authLocalDataSource.setIsUserLoggedIn(isUserLoggedIn: true);
        });

        return const Right(unit);
      } on UserNotFoundException {
        return Left(UserNotFoundFailure());
      } on WrongPasswordException {
        return Left(WrongPasswordFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> faceBookLogIn() async {
    if (await networkConnectionChecker.isConnected) {
      try {
        UserCredential userCredential =
            await authRemoteDataSource.faceBookLogIn();
        AuthModel authModel = AuthModel(
            userName: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email!,
            phone: userCredential.user!.phoneNumber ?? '',
            password: '');
        await authRemoteDataSource.setUserData(authModel);
        await authLocalDataSource.setUserData(authModel);
        await authLocalDataSource.setIsUserLoggedIn(isUserLoggedIn: true);

        return const Right(unit);
      } on FaceBookLogInException {
        return Left(FaceBookLogInFailure());
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(OfflineFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> googleLogIn() async {
    if (await networkConnectionChecker.isConnected) {
      try {
        UserCredential userCredential =
            await authRemoteDataSource.googleLogIn();
        AuthModel authModel = AuthModel(
            userName: userCredential.user!.displayName ?? '',
            email: userCredential.user!.email ?? '',
            phone: userCredential.user!.phoneNumber ?? '');
        await authRemoteDataSource.setUserData(authModel);
        await authLocalDataSource.setUserData(authModel);
        await authLocalDataSource.setIsUserLoggedIn(isUserLoggedIn: true);

        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      } catch (e) {
        return Left(OfflineFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    if (await networkConnectionChecker.isConnected) {
      try {
        await authLocalDataSource.clearUserData();
        await authLocalDataSource.setIsUserLoggedIn(isUserLoggedIn: false);
        await authRemoteDataSource.logOut();

        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> getPhoneNumber(
      {required String completePhoneNumber}) async {
    if (await networkConnectionChecker.isConnected) {
      try {
        await authRemoteDataSource.submitPhoneNumber(
            completePhoneNumber: completePhoneNumber);

        return const Right(unit);
      } on InvalidPhoneNumberException {
        return Left(InvalidPhoneNumberFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneNumber(
      {required String otpCode, required String completePhoneNumber}) async {
    if (await networkConnectionChecker.isConnected) {
      try {
        AuthModel authModel = AuthModel(
            userName: '', email: '', password: '', phone: completePhoneNumber);

        await authRemoteDataSource
            .submitOTPCode(otpCode: otpCode)
            .then((value) async {
          await authLocalDataSource.setUserData(authModel);
          await authRemoteDataSource.setUserData(authModel);
          await authLocalDataSource.setIsUserLoggedIn(isUserLoggedIn: true);
        });

        return const Right(unit);
      } on WrongOTPCodeException {
        return Left(WrongOTPCodeFailure());
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  bool goToHomeViewOrLogInView() {
    bool isUserLoggedIn = authLocalDataSource.getIsUserLoggedIn() ?? false;
    return isUserLoggedIn;
  }
}
