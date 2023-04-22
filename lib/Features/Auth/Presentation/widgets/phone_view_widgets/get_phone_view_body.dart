import 'package:flutter/material.dart';

import 'custom_phone_form_field.dart';

class GetPhoneNumberViewBody extends StatelessWidget {
  final double width, height;
  const GetPhoneNumberViewBody(
      {super.key, required this.width, required this.height});

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
      child: CustomPhoneFormField(
        height: height,
        width: width,
      ),
    );
  }
}
