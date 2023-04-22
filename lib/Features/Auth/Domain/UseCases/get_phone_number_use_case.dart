import 'package:dartz/dartz.dart';

import '../../../../core/Errors/failures.dart';
import '../Repositories/auth_repository.dart';

class GetPhoneNumberUseCase {
  final AuthRepository authRepository;

  GetPhoneNumberUseCase({required this.authRepository});
  Future<Either<Failure, Unit>> call({
    required String completePhoneNumber,
  }) async {
    return await authRepository.getPhoneNumber(
        completePhoneNumber: completePhoneNumber);
  }
}
