import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failure.dart';
import '../Entites/auth_entity.dart';
 import '../Repositories/auth_repository.dart';

class EmailAndPasswordLogInUseCase {
  final AuthRepository authRepository;

  EmailAndPasswordLogInUseCase({required this.authRepository});
  Future<Either<Failure, Unit>> call(AuthEntity authEntity) async {
    return await authRepository.emailAndPasswordLogIn(authEntity);
  }
}
