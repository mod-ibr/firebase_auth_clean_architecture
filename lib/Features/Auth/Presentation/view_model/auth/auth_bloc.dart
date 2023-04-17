import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/Entites/auth_entity.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/create_account_use_case.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/email_and_passwrod_login_use_case.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/facebook_login_use_case.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/google_login_use_case.dart.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/log_out_use_case.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/phone_login_use_case.dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Errors/errors_strings.dart';
import '../../../../../Core/Errors/failure.dart';
import '../../../../../Core/Utils/Constants/auth_constants.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateAccountUseCase createAccountUseCase;
  final EmailAndPasswordLogInUseCase emailAndPasswordLogInUseCase;
  final FaceBookLogInUseCase faceBookLogInUseCase;
  final GoogleLogInUseCase googleLogInUseCase;
  final LogOutUseCase logOutUseCase;
  final PhoneLogInUseCase phoneLogInUseCase;
  bool isPasswordVisible = false;
  String completePhoneNumber = '';
  String countryCode = '';
  String phoneNumber = '';
  String? otpCode;
  AuthBloc(
      {required this.createAccountUseCase,
      required this.emailAndPasswordLogInUseCase,
      required this.faceBookLogInUseCase,
      required this.googleLogInUseCase,
      required this.logOutUseCase,
      required this.phoneLogInUseCase})
      : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoadingSplashViewEvent) {
        emit(LoadingSplashViewState());
        Future.delayed(const Duration(
            seconds: AuthConstants.kSplashScreenDurationInSecond));
        emit(LoadedSplashViewState());
      } else if (event is EmailAndPasswordLogInEvent) {
        emit(LoadingAuthState());
        final Either<Failure, Unit> failureOrSuccess =
            (await emailAndPasswordLogInUseCase.call(event.authEntity))
                as Either<Failure, Unit>;

        failureOrSuccess.fold(
          (failure) =>
              emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
          (success) => emit(SucceededAuthState()),
        );
      } else if (event is GoogleLogInEvent) {
        emit(LoadingAuthState());
        final Either<Failure, Unit> failureOrSuccess =
            (await googleLogInUseCase.call()) as Either<Failure, Unit>;

        failureOrSuccess.fold(
          (failure) =>
              emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
          (success) => emit(SucceededAuthState()),
        );
      } else if (event is FacebookLogInEvent) {
        emit(LoadingAuthState());
        final Either<Failure, Unit> failureOrSuccess =
            (await faceBookLogInUseCase.call()) as Either<Failure, Unit>;

        failureOrSuccess.fold(
          (failure) =>
              emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
          (success) => emit(SucceededAuthState()),
        );
      } else if (event is CreateAccountEvent) {
        emit(LoadingAuthState());
        final Either<Failure, Unit> failureOrSuccess =
            (await createAccountUseCase.call(event.authEntity))
                as Either<Failure, Unit>;

        failureOrSuccess.fold(
          (failure) =>
              emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
          (success) => emit(SucceededAuthState()),
        );
      } else if (event is LogOutEvent) {
        emit(LoadingAuthState());
        final Either<Failure, Unit> failureOrSuccess =
            (await logOutUseCase.call()) as Either<Failure, Unit>;

        failureOrSuccess.fold(
          (failure) =>
              emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
          (success) => emit(SucceededAuthState()),
        );
      } else if (event is ToggelPasswordVisibilityEvent) {
        isPasswordVisible = !isPasswordVisible;
        emit(ToggelPasswordVisibilityState(
            isPasswordVisible: isPasswordVisible));
      } else if (event is GetPhoneNumberEvent) {
        emit(LoadingAuthState());
        completePhoneNumber = event.completePhoneNumber;
        countryCode = event.countryCode;
        phoneNumber = event.phoneNumber;
      } else if (event is VerifyPhoneNumberEvent) {
        emit(LoadingAuthState());
        final Either<Failure, Unit> failureOrSuccess =
            (await phoneLogInUseCase.call(
                completePhoneNumber: completePhoneNumber,
                countryCode: countryCode,
                phoneNumber: phoneNumber,
                otpCode: event.otpCode)) as Either<Failure, Unit>;

        failureOrSuccess.fold(
          (failure) =>
              emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
          (success) => emit(SucceededAuthState()),
        );
      }
    });
  }

  AuthState _eitherDoneMessageOrErrorState(
      {required Either<Failure, Unit> either, required String message}) {
    return either.fold(
      (failure) => ErrorAuthState(message: _mapFailureToMessage(failure)),
      (success) => SucceededAuthState(),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ErrorsStrings.serverFailureMessage;
      case OfflineFailure:
        return ErrorsStrings.offlineFailureMessage;
      case NoSavedUserFailure:
        return ErrorsStrings.noSavedUserFailureeMessage;
      case WeakPasswordFailure:
        return ErrorsStrings.weakPasswordFailureMessage;
      case EmailAlreadyInUseFailure:
        return ErrorsStrings.emailAlreadyInUseFailureMessage;
      case UserNotFoundFailure:
        return ErrorsStrings.userNotFoundFailureMessage;
      case WrongPasswordFailure:
        return ErrorsStrings.wrongPasswordFailureMessage;
      case FaceBookLogInFailure:
        return ErrorsStrings.faceBookLogInFailureMessage;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
