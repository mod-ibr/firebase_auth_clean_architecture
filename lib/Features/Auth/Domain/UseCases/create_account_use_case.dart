import 'package:dartz/dartz.dart';

import '../../../../Core/Errors/failure.dart';
import '../Entites/auth_entity.dart';
import '../Repositories/auth_repository.dart';

class CreateAccount {
  final AuthRepository authRepository;

  CreateAccount({required this.authRepository});
  Future<Either<Failure, Unit>> call(AuthEntity authEntity) async {
    return await authRepository.createAccount(authEntity);
  }
}