import '../Repositories/auth_repository.dart';

class GoToHomeViewOrLoginViewUseCase {
  final AuthRepository authRepository;

  GoToHomeViewOrLoginViewUseCase({required this.authRepository});
  bool call() {
    return authRepository.goToHomeViewOrLogInView();
  }
}
