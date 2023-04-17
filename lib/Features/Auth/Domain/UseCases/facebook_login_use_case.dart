import '../../../../core/Errors/failure.dart';
 import 'package:dartz/dartz.dart';

import '../Repositories/auth_repository.dart';

class FaceBookLogIn {
  final AuthRepository authRepository;

  FaceBookLogIn({required this.authRepository});
  Future<Either<Failure, Unit>> call() async {
    return await authRepository.faceBookLogIn();
  }
}
