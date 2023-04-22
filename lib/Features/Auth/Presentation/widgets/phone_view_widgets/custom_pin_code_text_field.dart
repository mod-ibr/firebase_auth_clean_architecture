import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view_model/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class CustomePinCodeTextField extends StatefulWidget {
  const CustomePinCodeTextField({
    super.key,
  });

  @override
  State<CustomePinCodeTextField> createState() =>
      _CustomePinCodeTextFieldState();
}

class _CustomePinCodeTextFieldState extends State<CustomePinCodeTextField> {
  late FocusNode _otpPinCodeFocusNode;
  @override
  void initState() {
    super.initState();
    _otpPinCodeFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PinCodeTextField(
      focusNode: _otpPinCodeFocusNode,
      appContext: context,
      autoFocus: true,
      cursorColor: Colors.amber[900],
      keyboardType: TextInputType.number,
      length: 6,
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.circle,
        fieldHeight: width * 0.13,
        fieldWidth: width * 0.13,
        borderWidth: 1.5,
        activeColor: Colors.amber[900],
        inactiveColor: Colors.amber[900]!.withOpacity(0.5),
        inactiveFillColor: Colors.white,
        activeFillColor: Colors.amber[900]!.withOpacity(0.3),
        selectedColor: Colors.amber[900]!,
        selectedFillColor: Colors.white24,
      ),
      animationDuration: const Duration(milliseconds: 500),
      backgroundColor: Colors.white24,
      enableActiveFill: true,
      // onCompleted: (value) => widget.otpPinCodeController.text = value,
      onChanged: (value) {
        BlocProvider.of<AuthBloc>(context).otpCode = value;
      },
    );
  }
}
