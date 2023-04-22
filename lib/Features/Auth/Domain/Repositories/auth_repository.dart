import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failures.dart';
import '../Entites/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> emailAndPasswordLogIn(AuthEntity authEntity);

  Future<Either<Failure, Unit>> getPhoneNumber({
    required String completePhoneNumber,
  });
  Future<Either<Failure, Unit>> verifyPhoneNumber(
      {required String otpCode, required String completePhoneNumber});

  Future<Either<Failure, Unit>> googleLogIn();
  Future<Either<Failure, Unit>> faceBookLogIn();
  Future<Either<Failure, Unit>> createAccount(AuthEntity authEntity);
  Future<Either<Failure, Unit>> logOut();
  bool goToHomeViewOrLogInView();
}
