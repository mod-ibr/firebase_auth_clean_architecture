import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failures.dart';
import '../Repositories/auth_repository.dart';

class VerifyPhoneNumberUseCase {
  final AuthRepository authRepository;

  VerifyPhoneNumberUseCase({required this.authRepository});
  Future<Either<Failure, Unit>> call(
      {required String otpCode, required String completePhoneNumber}) async {
    return await authRepository.verifyPhoneNumber(
        otpCode: otpCode, completePhoneNumber: completePhoneNumber);
  }
}
