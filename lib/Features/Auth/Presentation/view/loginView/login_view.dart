import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/widgets/login_view_widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LogInView extends StatelessWidget {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: LogInViewBody(width: width, height: height),
    );
  }
}
