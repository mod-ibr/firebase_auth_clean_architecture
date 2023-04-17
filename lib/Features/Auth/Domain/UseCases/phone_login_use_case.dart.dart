import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failure.dart';
import '../Entites/auth_entity.dart';
import '../Repositories/auth_repository.dart';

class PhoneLogIn {
  final AuthRepository authRepository;

  PhoneLogIn({required this.authRepository});
  Future<Either<Failure, Unit>> call(AuthEntity authEntity) async {
    return await authRepository.phoneLogIn(authEntity);
  }
}
