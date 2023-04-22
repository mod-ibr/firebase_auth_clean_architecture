import 'package:firebase_auth_clean_arch/Features/Auth/Data/DataSources/auth_local_data_source.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Data/Repositories/auth_repository_impl.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/create_account_use_case.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/email_and_passwrod_login_use_case.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/facebook_login_use_case.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/go_to_home_view_or_login_view_use_case.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/google_login_use_case.dart.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/log_out_use_case.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/UseCases/verify_phone_number_use_case.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view_model/auth/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Features/Auth/Data/DataSources/auth_remote_data_source.dart';
import 'Features/Auth/Domain/UseCases/get_phone_number_use_case.dart';
import 'core/Network/network_connection_checker.dart';

final sl = GetIt.instance;

Future<void> servicesLocator() async {
  //! Features - Auth

  // Bloc

  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
        goToHomeViewOrLoginViewUseCase: sl(),
        createAccountUseCase: sl(),
        emailAndPasswordLogInUseCase: sl(),
        faceBookLogInUseCase: sl(),
        googleLogInUseCase: sl(),
        logOutUseCase: sl(),
        getPhoneNumberUseCase: sl(),
        verifyPhoneNumberUseCase: sl()),
  );

  // UseCases
  sl.registerLazySingleton(
      () => GoToHomeViewOrLoginViewUseCase(authRepository: sl()));

  sl.registerLazySingleton(() => CreateAccountUseCase(authRepository: sl()));
  sl.registerLazySingleton(
      () => EmailAndPasswordLogInUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => FaceBookLogInUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => GoogleLogInUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => LogOutUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => GetPhoneNumberUseCase(authRepository: sl()));
  sl.registerLazySingleton(
      () => VerifyPhoneNumberUseCase(authRepository: sl()));

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authLocalDataSource: sl(),
      authRemoteDataSource: sl(),
      networkConnectionChecker: sl(),
    ),
  );

  // DataSources

  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceSharedPrefes(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceFireBase());
  //! Core
  sl.registerLazySingleton<NetworkConnectionChecker>(
      () => NetworkConnectionCheckerImpl(sl()));

  //! External
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
