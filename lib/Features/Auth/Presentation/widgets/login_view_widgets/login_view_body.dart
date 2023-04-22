import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/widgets/login_view_widgets/custom_login_form_field.dart';
import 'package:flutter/material.dart';

class LogInViewBody extends StatelessWidget {
  final double width, height;
  const LogInViewBody({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: width * 0.03,
          right: width * 0.03,
          bottom: width * 0.03,
          top: width * 0.1),
      width: width,
      height: height,
      child: CustomLogInFormField(
        height: height,
        width: width,
      ),
    );
  }
}
