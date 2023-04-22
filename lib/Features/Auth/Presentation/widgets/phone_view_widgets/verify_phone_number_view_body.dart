import 'package:flutter/material.dart';

import 'otp_widget.dart';

class VerifyPhoneNumberViewBody extends StatelessWidget {
  final double width, height;
  final String phoneNumber;
  const VerifyPhoneNumberViewBody(
      {super.key,
      required this.width,
      required this.height,
      required this.phoneNumber});

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
      child: OTPWidget(
        phoneNumber: phoneNumber,
        height: height,
        width: width,
      ),
    );
  }
}
