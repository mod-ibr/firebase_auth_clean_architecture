import 'dart:async';
import 'package:firebase_auth_clean_arch/Core/Utils/Constants/auth_constants.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view_model/auth/auth_bloc.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/widgets/splash_view_widgets/splash_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_view_or_auth_view.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  bool isUserLoggedIn = false;

  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthBloc>(context).add(GoToHomeViewOrLogInViewEvent());
    // Create animation controller
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Create logo animation from top to center
    _logoAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Create text animation from bottom to center
    _textAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Start the animation
    _controller.forward();
    Timer(const Duration(seconds: AuthConstants.kSplashScreenDurationInSecond),
        () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeViewOrAuthView()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SplashViewWBody(
          width: width,
          height: height,
          logoAnimation: _logoAnimation,
          textAnimation: _textAnimation),
    );
  }
}
