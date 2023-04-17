import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failure.dart';
import '../Repositories/auth_repository.dart';

class GoogleLogIn {
  final AuthRepository authRepository;

  GoogleLogIn({required this.authRepository});
  Future<Either<Failure, Unit>> call() async {
    return await authRepository.googleLogIn();
  }
}
