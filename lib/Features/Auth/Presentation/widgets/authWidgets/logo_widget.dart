import 'package:flutter/material.dart';

import 'custom_text.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: const Image(
            alignment: Alignment.center,
            fit: BoxFit.contain,
            image: AssetImage(
              'assets/images/logo.png',
            ),
          ),
        ),
        CustomText(
          text: title,
          alignment: Alignment.center,
          fontFamily: 'Ubuntu-Bold',
          fontSize: 25,
        ),
      ],
    );
  }
}
