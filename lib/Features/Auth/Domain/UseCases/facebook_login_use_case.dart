import '../../../../core/Errors/failures.dart';
 import 'package:dartz/dartz.dart';

import '../Repositories/auth_repository.dart';

class FaceBookLogInUseCase {
  final AuthRepository authRepository;

  FaceBookLogInUseCase({required this.authRepository});
  Future<Either<Failure, Unit>> call() async {
    return await authRepository.faceBookLogIn();
  }
}
