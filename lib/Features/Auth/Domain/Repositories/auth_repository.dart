import 'package:dartz/dartz.dart';

import '../../../../Core/Errors/failure.dart';
import '../Entites/auth_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> logInWithEmailAndPassword(
      AuthEntity authEntity);

  Future<Either<Failure, Unit>> logInWithPhone(AuthEntity authEntity);
  Future<Either<Failure, Unit>> logInWithGoogle();
  Future<Either<Failure, Unit>> logInWithFaceBook();
  Future<Either<Failure, Unit>> createAccount(AuthEntity authEntity);
  Future<Either<Failure, Unit>> logOut();
}
