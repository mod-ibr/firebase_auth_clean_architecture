import 'package:dartz/dartz.dart';

import '../../../../Core/Errors/failure.dart';
import '../Repositories/auth_repository.dart';

class LogInWithGoogle {
  final AuthRepository authRepository;

  LogInWithGoogle({required this.authRepository});
  Future<Either<Failure, Unit>> call() async {
    return await authRepository.logInWithFaceBook();
  }
}
