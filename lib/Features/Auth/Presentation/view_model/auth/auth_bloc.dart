import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/go_to_home_view_or_login_view_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Errors/errors_strings.dart';
import '../../../../../core/Errors/failures.dart';
import '../../../Domain/Entites/auth_entity.dart';
import '../../../Domain/UseCases/create_account_use_case.dart';
import '../../../Domain/UseCases/email_and_passwrod_login_use_case.dart';
import '../../../Domain/UseCases/facebook_login_use_case.dart';
import '../../../Domain/UseCases/google_login_use_case.dart.dart';
import '../../../Domain/UseCases/log_out_use_case.dart';
import '../../../Domain/UseCases/get_phone_number_use_case.dart';
import '../../../Domain/UseCases/verify_phone_number_use_case.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CreateAccountUseCase createAccountUseCase;
  final EmailAndPasswordLogInUseCase emailAndPasswordLogInUseCase;
  final FaceBookLogInUseCase faceBookLogInUseCase;
  final GoogleLogInUseCase googleLogInUseCase;
  final LogOutUseCase logOutUseCase;
  final GetPhoneNumberUseCase getPhoneNumberUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final GoToHomeViewOrLoginViewUseCase goToHomeViewOrLoginViewUseCase;
  bool isPasswordVisible = false;
  String completePhoneNumber = '';
  String countryCode = '';
  String phoneNumber = '';
  String otpCode = '';
  bool isLoggedIn = false;
  AuthBloc(
      {required this.createAccountUseCase,
      required this.emailAndPasswordLogInUseCase,
      required this.faceBookLogInUseCase,
      required this.googleLogInUseCase,
      required this.logOutUseCase,
      required this.getPhoneNumberUseCase,
      required this.verifyPhoneNumberUseCase,
      required this.goToHomeViewOrLoginViewUseCase})
      : super(AuthInitial()) {
    on<AuthEvent>(
      (event, emit) async {
        if (event is GoToHomeViewOrLogInViewEvent) {
          emit(LoadingAuthState());
          isLoggedIn = goToHomeViewOrLoginViewUseCase.call();
          if (isLoggedIn) {
            emit(LoggedInState());
          } else {
            emit(NotLoggedInState());
          }
        } else if (event is EmailAndPasswordLogInEvent) {
          emit(LoadingAuthState());
          final Either<Failure, Unit> failureOrSuccess =
              await emailAndPasswordLogInUseCase.call(event.authEntity);

          failureOrSuccess.fold(
            (failure) =>
                emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
            (success) => emit(SucceededAuthState()),
          );
        } else if (event is GoogleLogInEvent) {
          emit(LoadingAuthState());
          final Either<Failure, Unit> failureOrSuccess =
              await googleLogInUseCase.call();

          failureOrSuccess.fold(
            (failure) =>
                emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
            (success) => emit(SucceededAuthState()),
          );
        } else if (event is FacebookLogInEvent) {
          emit(LoadingAuthState());
          final Either<Failure, Unit> failureOrSuccess =
              await faceBookLogInUseCase.call();

          failureOrSuccess.fold(
            (failure) =>
                emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
            (success) => emit(SucceededAuthState()),
          );
        } else if (event is CreateAccountEvent) {
          emit(LoadingAuthState());
          final Either<Failure, Unit> failureOrSuccess =
              (await createAccountUseCase.call(event.authEntity));

          failureOrSuccess.fold(
            (failure) =>
                emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
            (success) => emit(SucceededAuthState()),
          );
        } else if (event is LogOutEvent) {
          emit(LoadingAuthState());
          final Either<Failure, Unit> failureOrSuccess =
              (await logOutUseCase.call());

          failureOrSuccess.fold(
            (failure) =>
                emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
            (success) => emit(SucceededAuthState()),
          );
        } else if (event is ToggelPasswordVisibilityEvent) {
          if (!isPasswordVisible) {
            isPasswordVisible = true;
            emit(HidePasswordState(isPasswordVisible: isPasswordVisible));
          } else {
            isPasswordVisible = false;
            emit(ShowPasswordState(isPasswordVisible: isPasswordVisible));
          }
        } else if (event is GetPhoneNumberEvent) {
          emit(LoadingAuthState());
          final Either<Failure, Unit> failureOrSuccess =
              await getPhoneNumberUseCase.call(
                  completePhoneNumber: event.completePhoneNumber);
          failureOrSuccess.fold(
            (failure) =>
                emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
            (success) => emit(SucceededGetPhoneNumberState(
                completePhoneNumber: event.completePhoneNumber)),
          );
        } else if (event is VerifyPhoneNumberEvent) {
          emit(LoadingAuthState());
          final Either<Failure, Unit> failureOrSuccess =
              await verifyPhoneNumberUseCase.call(
                  otpCode: event.otpCode,
                  completePhoneNumber: event.completePhoneNumber);

          failureOrSuccess.fold(
            (failure) =>
                emit(ErrorAuthState(message: _mapFailureToMessage(failure))),
            (success) => emit(SucceededVerifyPhoneNumberState()),
          );
        }
      },
    );
  }

  // AuthState _eitherDoneMessageOrErrorState(
  //     {required Either<Failure, Unit> either, required String message}) {
  //   return either.fold(
  //     (failure) => ErrorAuthState(message: _mapFailureToMessage(failure)),
  //     (success) => SucceededAuthState(),
  //   );
  // }

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
      case InvalidPhoneNumberFailure:
        return ErrorsStrings.invalidPhoneNumberFailureMessage;
      case WrongOTPCodeFailure:
        return ErrorsStrings.wrongOTPCodeFailureMessage;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
