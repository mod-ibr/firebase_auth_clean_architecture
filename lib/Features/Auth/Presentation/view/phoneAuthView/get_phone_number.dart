import 'package:flutter/material.dart';

import '../../widgets/phone_view_widgets/get_phone_view_body.dart';

class GetPhoneNumberView extends StatelessWidget {
  const GetPhoneNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetPhoneNumberViewBody(height: height, width: width),
    );
  }
}
