part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoadingSplashViewState extends AuthState {}

class LoadedSplashViewState extends AuthState {}

class LoadingAuthState extends AuthState {}

class SucceededAuthState extends AuthState {}

class ErrorAuthState extends AuthState {
  final String message;

  const ErrorAuthState({required this.message});
  @override
  List<Object> get props => [message];
}

class ToggelPasswordVisibilityState extends AuthState {
  final bool isPasswordVisible;
  const ToggelPasswordVisibilityState({required this.isPasswordVisible});
  @override
  List<Object> get props => [isPasswordVisible];
}

class SucceededGetPhoneNumberState extends AuthState {
  final String completePhoneNumber, countryCode, phoneNumber;
  const SucceededGetPhoneNumberState(
      {required this.completePhoneNumber,
      required this.countryCode,
      required this.phoneNumber});
  @override
  List<Object> get props => [completePhoneNumber, countryCode, phoneNumber];
}

class SucceededVerifyPhoneNumberState extends AuthEvent {}
