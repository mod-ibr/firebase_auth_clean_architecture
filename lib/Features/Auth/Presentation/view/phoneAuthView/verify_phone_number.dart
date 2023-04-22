import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/widgets/phone_view_widgets/verify_phone_number_view_body.dart';
import 'package:flutter/material.dart';

class VerifyPhoneNumberView extends StatelessWidget {
  final String phoneNumber;
  const VerifyPhoneNumberView({super.key, required this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: VerifyPhoneNumberViewBody(
          height: height, width: width, phoneNumber: phoneNumber),
    );
  }
}
