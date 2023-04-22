import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButtonSocial extends StatelessWidget {
  final String text;
  final String imageName;
  final Function onPress;

  const CustomButtonSocial({
    super.key,
    required this.text,
    required this.imageName,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        color: Colors.grey.shade50,
      ),
      child: MaterialButton(
        onPressed: () => onPress(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding:
            const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
        color: Colors.white38,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imageName),
            const SizedBox(
              width: 40,
            ),
            CustomText(
              text: text,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomButtonLogo extends StatelessWidget {
  String imageName;
  final Function onPressed;
  final IconData? iconData;
  CustomButtonLogo({
    super.key,
    this.iconData,
    this.imageName = '',
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: Colors.black12, width: 1),
      ),
      child: InkWell(
        onTap: () => onPressed(),
        child: Container(
          width: width * 0.15,
          height: width * 0.15,
          padding: const EdgeInsets.all(12),
          child: (imageName.isNotEmpty)
              ? Image.asset(
                  imageName,
                  fit: BoxFit.contain,
                )
              : Icon(
                  iconData,
                  size: width * 0.08,
                ),
        ),
      ),
    );
  }
}
