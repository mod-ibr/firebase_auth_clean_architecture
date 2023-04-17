import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failure.dart';
import '../Entites/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> emailAndPasswordLogIn(AuthEntity authEntity);
  Future<Either<Failure, Unit>> phoneLogIn(
      {required String completePhoneNumber,
      required String countryCode,
      required String phoneNumber,
      String? otpCode});
  Future<Either<Failure, Unit>> googleLogIn();
  Future<Either<Failure, Unit>> faceBookLogIn();
  Future<Either<Failure, Unit>> createAccount(AuthEntity authEntity);
  Future<Either<Failure, Unit>> logOut();
}
