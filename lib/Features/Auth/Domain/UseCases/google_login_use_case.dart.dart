import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failures.dart';
import '../Repositories/auth_repository.dart';

class GoogleLogInUseCase {
  final AuthRepository authRepository;

  GoogleLogInUseCase({required this.authRepository});
  Future<Either<Failure, Unit>> call() async {
    return await authRepository.googleLogIn();
  }
}
