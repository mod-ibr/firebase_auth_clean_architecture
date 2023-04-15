import 'package:dartz/dartz.dart';

import '../../../../Core/Errors/failure.dart';
import '../Repositories/auth_repository.dart';

class LogOut {
  final AuthRepository authRepository;

  LogOut({required this.authRepository});
  Future<Either<Failure, Unit>> call() async {
    return await authRepository.logOut();
  }
}
