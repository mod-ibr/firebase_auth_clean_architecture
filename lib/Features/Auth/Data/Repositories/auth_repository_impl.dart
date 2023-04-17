import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Data/Models/auth_model.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/Entites/auth_entity.dart';
import 'package:firebase_auth_clean_arch/core/Errors/failure.dart';

import '../../../../core/Errors/exception.dart';
import '../../../../core/Network/network_connection_checker.dart';
import '../../Domain/Repositories/auth_repository.dart';
import '../DataSources/auth_local_data_source.dart';
import '../DataSources/auth_remote_data_source.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDataSource postLocalDataSource;
  final AuthRemoteDataSource postRemoteDataSource;
  final NetworkConnectionChecker networkConnectionChecker;

  AuthRepositoryImpl(
      {required this.postLocalDataSource,
      required this.postRemoteDataSource,
      required this.networkConnectionChecker});

  @override
  Future<Either<Failure, Unit>> createAccount(AuthEntity authEntity) async {
    if (await networkConnectionChecker.isConnected) {
      try {
        AuthModel authModel = AuthModel(
            userName: authEntity.userName,
            email: authEntity.email,
            password: authEntity.password,
            phone: authEntity.phone);

        await postRemoteDataSource.createAccount(authModel);
        await postRemoteDataSource.setUserData(authModel);
        await postLocalDataSource.setUserData(authModel);
        await postLocalDataSource.setIsUserLoggedIn(isUserLoggedIn: true);

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
            userName: authEntity.userName,
            email: authEntity.email,
            password: authEntity.password,
            phone: authEntity.phone);

        await postRemoteDataSource.emailAndPasswordLogIn(authModel);

        await postLocalDataSource.setUserData(authModel);
        await postLocalDataSource.setIsUserLoggedIn(isUserLoggedIn: true);

        return const Right(unit);
      } on UserNotFoundException {
        return Left(UserNotFoundFailure());
      } on WrongPasswordException {
        return Left(WeakPasswordFailure());
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
            await postRemoteDataSource.faceBookLogIn();
        AuthModel authModel = AuthModel(
            userName: userCredential.user!.displayName!,
            email: userCredential.user!.email!,
            phone: userCredential.user!.phoneNumber!);
        await postRemoteDataSource.setUserData(authModel);
        await postLocalDataSource.setUserData(authModel);
        await postLocalDataSource.setIsUserLoggedIn(isUserLoggedIn: true);

        return const Right(unit);
      } on FaceBookLogInException {
        return Left(FaceBookLogInFailure());
      } on ServerException {
        return Left(ServerFailure());
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
            await postRemoteDataSource.googleLogIn();
        AuthModel authModel = AuthModel(
            userName: userCredential.user!.displayName!,
            email: userCredential.user!.email!,
            phone: userCredential.user!.phoneNumber!);
        await postRemoteDataSource.setUserData(authModel);
        await postLocalDataSource.setUserData(authModel);
        await postLocalDataSource.setIsUserLoggedIn(isUserLoggedIn: true);

        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    if (await networkConnectionChecker.isConnected) {
      try {
        await postLocalDataSource.clearUserData();
        await postLocalDataSource.setIsUserLoggedIn(isUserLoggedIn: false);
        await postRemoteDataSource.logOut();

        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> phoneLogIn(AuthEntity authEntity) {
    // TODO: implement phoneLogIn
    throw UnimplementedError();
  }
}
