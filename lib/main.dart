import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view/splashView/splash_view.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view_model/auth/auth_bloc.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view_model/auth/auth_bloc_observer.dart';
import 'package:firebase_auth_clean_arch/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'services_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.servicesLocator();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AuthBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluter FireBase Auth',
      home: SplashScreen(),
    );
  }
}
