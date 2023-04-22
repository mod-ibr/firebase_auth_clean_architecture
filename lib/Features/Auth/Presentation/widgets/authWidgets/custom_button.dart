import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;

  final Color color;

  final Function onPress;

  const CustomButton({
    super.key,
    required this.onPress,
    this.text = 'Write text ',
    this.color = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 20,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.all(10),
      onPressed: () => onPress(),
      color: color,
      child: SizedBox(
        height: 30,
        child: CustomText(
          alignment: Alignment.center,
          text: text,
          color: Colors.black,
        ),
      ),
    );
  }
}
