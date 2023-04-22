import 'package:firebase_auth_clean_arch/Core/Widgets/loading_widget.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view/loginView/login_view.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view_model/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../Core/Utils/Functions/snackbar_message.dart';
import '../../view/phoneAuthView/verify_phone_number.dart';
import '../authWidgets/custom_button.dart';
import '../authWidgets/custom_text.dart';
import '../authWidgets/logo_widget.dart';

class CustomPhoneFormField extends StatefulWidget {
  final double width, height;

  const CustomPhoneFormField({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  State<CustomPhoneFormField> createState() => _CustomPhoneFormFieldState();
}

class _CustomPhoneFormFieldState extends State<CustomPhoneFormField> {
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();

  final TextEditingController _phoneController = TextEditingController();
  late FocusNode _phoneFocusNode;
  late String completePhoneNumber, countryCode, countryISOCode;
  @override
  void initState() {
    super.initState();
    _phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SucceededGetPhoneNumberState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => VerifyPhoneNumberView(
                phoneNumber: state.completePhoneNumber,
              ),
            ),
          );
        } else if (state is ErrorAuthState) {
          SnackBarMessage()
              .showErrorSnackBar(message: state.message, context: context);
        }
      },
      builder: (context, state) {
        if (state is LoadingAuthState) {
          return const LoadingWidget();
        }
        return _formWidget();
      },
    );
  }

  Widget _formWidget() {
    return Form(
      key: _phoneFormKey,
      child: ListView(
        children: [
          // Logo And app name Section
          const LogoWidget(title: 'Phone LogIn'),
          SizedBox(height: widget.height * 0.05),
          const CustomText(
            text: 'Log in with Your Phone Number ',
            alignment: Alignment.centerLeft,
            fontWeight: FontWeight.bold,
            fontSize: 23,
          ),
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: const CustomText(
              text: 'Please enter your phone number ',
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            child: const CustomText(
              text: 'without the country code.',
              color: Colors.black54,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          _buildPhoneFormField(widget.width, widget.height),
          const SizedBox(height: 55),
          CustomButton(
            onPress: () => _verify(context),
            text: 'Verify',
          ),
          const SizedBox(height: 40),

          //  Log in Route
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: 'have an account, ',
                alignment: Alignment.center,
                fontSize: 13,
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LogInView()));
                },
                child: const CustomText(
                  text: 'Log in here',
                  color: Colors.blue,
                  alignment: Alignment.center,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

// Phone TextField
  Widget _buildPhoneFormField(double width, double height) {
    return IntlPhoneField(
      focusNode: _phoneFocusNode,
      controller: _phoneController,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber[900]!),
        ),
        hintText: 'Phone Number',
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amber[900]!),
        ),
      ),
      style: TextStyle(letterSpacing: 3, fontSize: width * 0.04512),
      initialCountryCode: 'EG',
      autofocus: true,
      autovalidateMode: AutovalidateMode.disabled,
      cursorColor: Colors.amber[900]!,
      onChanged: (phone) {
        completePhoneNumber = phone.completeNumber;
        countryCode = phone.countryCode;
        countryISOCode = phone.countryISOCode;
      },
    );
  }

// Verify Button Function
  void _verify(context) {
    if (_phoneFormKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(GetPhoneNumberEvent(
        completePhoneNumber: completePhoneNumber,
      ));
    } else {}
  }
}
