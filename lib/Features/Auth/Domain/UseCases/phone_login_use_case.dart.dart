import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failure.dart';
import '../Repositories/auth_repository.dart';

class PhoneLogInUseCase {
  final AuthRepository authRepository;

  PhoneLogInUseCase({required this.authRepository});
  Future<Either<Failure, Unit>> call(
      {required String completePhoneNumber,
      required String countryCode,
      required String phoneNumber,
      String? otpCode}) async {
    return await authRepository.phoneLogIn(
        completePhoneNumber: completePhoneNumber,
        countryCode: countryCode,
        phoneNumber: phoneNumber,
        otpCode: otpCode);
  }
}
