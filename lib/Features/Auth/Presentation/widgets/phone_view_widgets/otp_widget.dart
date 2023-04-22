import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view_model/auth/auth_bloc.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/widgets/authWidgets/logo_widget.dart';
import 'package:firebase_auth_clean_arch/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Utils/Functions/snackbar_message.dart';
import '../../../../../Core/Widgets/loading_widget.dart';
import '../authWidgets/custom_button.dart';
import '../authWidgets/custom_text.dart';
import 'custom_pin_code_text_field.dart';

class OTPWidget extends StatelessWidget {
  final double width, height;
  final String phoneNumber;

  const OTPWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.phoneNumber});

  verifyOptCode(context) {
    String otpCode = BlocProvider.of<AuthBloc>(context).otpCode;
    BlocProvider.of<AuthBloc>(context).add(VerifyPhoneNumberEvent(
        completePhoneNumber: phoneNumber, otpCode: otpCode));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SucceededVerifyPhoneNumberState) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeView()));
        } else if (state is ErrorAuthState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is LoadingAuthState) {
          return const LoadingWidget();
        }
        return _otpWidget(context);
      },
    );
  }

  Widget _otpWidget(BuildContext context) {
    return ListView(
      children: [
        // Logo And app name Section
        const LogoWidget(
          title: 'OTP Code',
        ),
        SizedBox(height: height * 0.05),
        const CustomText(
          text: 'Verify your phone number',
          alignment: Alignment.centerLeft,
          fontWeight: FontWeight.bold,
          fontSize: 38,
        ),
        SizedBox(height: height * 0.05),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text: TextSpan(
              text: 'Enter the 6-digit code numbers sent to ',
              style: TextStyle(
                  color: Colors.black54, fontSize: width * 0.05, height: 2),
              children: <TextSpan>[
                TextSpan(
                  text: phoneNumber,
                  style: TextStyle(
                    color: Colors.amber[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 35),
        const CustomePinCodeTextField(),
        // pinCodeWidget(context, width, height),
        const SizedBox(height: 35),
        CustomButton(
          onPress: () => verifyOptCode(context),
          text: 'verify',
        )
      ],
    );
  }
}
