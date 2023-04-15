import 'package:dartz/dartz.dart';

import '../../../../Core/Errors/failure.dart';
import '../Repositories/auth_repository.dart';

class LogInWithFaceBook {
  final AuthRepository authRepository;

  LogInWithFaceBook({required this.authRepository});
  Future<Either<Failure, Unit>> call() async {
    return await authRepository.logInWithFaceBook();
  }
}
