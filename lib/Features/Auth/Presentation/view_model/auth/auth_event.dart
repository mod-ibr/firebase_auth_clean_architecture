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

class LoadingSplashViewEvent extends AuthEvent {}

class FacebookLogInEvent extends AuthEvent {}

class GoogleLogInEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}

class CreateAccountEvent extends AuthEvent {
  final AuthEntity authEntity;

  const CreateAccountEvent({required this.authEntity});
  @override
  List<Object> get props => [authEntity];
}

class ToggelPasswordVisibilityEvent extends AuthEvent {
  final bool isPasswordVisible;

  const ToggelPasswordVisibilityEvent({required this.isPasswordVisible});
  @override
  List<Object> get props => [isPasswordVisible];
}

// class NavigateToSignUpViewEvent extends AuthEvent {}

// class NavigateToLogInViewEvent extends AuthEvent {}

// class NavigateToPhoneViewEvent extends AuthEvent {}

class GetPhoneNumberEvent extends AuthEvent {
  final String completePhoneNumber;
  final String countryCode;
  final String phoneNumber;
  const GetPhoneNumberEvent(
      {required this.completePhoneNumber,
      required this.countryCode,
      required this.phoneNumber});
  @override
  List<Object> get props => [completePhoneNumber, countryCode, phoneNumber];
}

class VerifyPhoneNumberEvent extends AuthEvent {
  final String otpCode;
  const VerifyPhoneNumberEvent({required this.otpCode});
  @override
  List<Object> get props => [otpCode];
}
