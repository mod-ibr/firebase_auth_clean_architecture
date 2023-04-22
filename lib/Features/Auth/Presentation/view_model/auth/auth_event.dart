part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class EmailAndPasswordLogInEvent extends AuthEvent {
  final AuthEntity authEntity;

  const EmailAndPasswordLogInEvent({required this.authEntity});
  @override
  List<Object> get props => [authEntity];
}

class FacebookLogInEvent extends AuthEvent {}

class GoogleLogInEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}

class CreateAccountEvent extends AuthEvent {
  final AuthEntity authEntity;

  const CreateAccountEvent({required this.authEntity});
  @override
  List<Object> get props => [authEntity];
}

class ToggelPasswordVisibilityEvent extends AuthEvent {}

class GoToHomeViewOrLogInViewEvent extends AuthEvent {}

class GetPhoneNumberEvent extends AuthEvent {
  final String completePhoneNumber;

  const GetPhoneNumberEvent({
    required this.completePhoneNumber,
  });
  @override
  List<Object> get props => [completePhoneNumber];
}

class VerifyPhoneNumberEvent extends AuthEvent {
  final String otpCode;
  final String completePhoneNumber;

  const VerifyPhoneNumberEvent(
      {required this.completePhoneNumber, required this.otpCode});
  @override
  List<Object> get props => [otpCode, completePhoneNumber];
}
