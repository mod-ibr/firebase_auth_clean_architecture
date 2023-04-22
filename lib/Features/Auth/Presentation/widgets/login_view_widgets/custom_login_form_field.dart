// ignore_for_file: must_be_immutable

import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view/phoneAuthView/get_phone_number.dart';
import 'package:firebase_auth_clean_arch/home_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Utils/Functions/snackbar_message.dart';
import '../../../../../Core/Widgets/loading_widget.dart';
import '../../view_model/auth/auth_bloc.dart';
import '../authWidgets/custom_button.dart';
import '../authWidgets/custom_button_social_and_logo.dart';
import '../authWidgets/custom_text.dart';
import '../authWidgets/custom_text_form_field.dart';
import '../authWidgets/logo_widget.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Domain/Entites/auth_entity.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view/signUpView/signup_view.dart';
import 'package:flutter/material.dart';

class CustomLogInFormField extends StatefulWidget {
  CustomLogInFormField({
    super.key,
    required this.height,
    required this.width,
  });
  final double width, height;
  bool isPasswordVisible = false;

  @override
  State<CustomLogInFormField> createState() => _CustomLogInFormFieldState();
}

class _CustomLogInFormFieldState extends State<CustomLogInFormField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SucceededAuthState) {
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
        return _formWidget(
            context: context,
            emailController: _emailController,
            passwordController: _passwordController,
            emailFocusNode: _emailFocusNode,
            passwordFocusNode: _passwordFocusNode,
            formKey: _formKey);
      },
    );
  }

  Widget _formWidget(
      {required BuildContext context,
      required TextEditingController emailController,
      required TextEditingController passwordController,
      required FocusNode emailFocusNode,
      required FocusNode passwordFocusNode,
      required GlobalKey<FormState> formKey}) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          // Logo
          const LogoWidget(title: 'Sign In'),
          SizedBox(height: widget.height * 0.05),
          CustomTextFormField(
            focusNode: _emailFocusNode,
            onSave: (value) {},
            controller: emailController,
            isPasswordField: false,
            text: 'Email',
            hint: 'example@gmail.com',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email Can\'t be Empty';
              } else if (value.length > 100) {
                return 'Too Long Email';
              }
            },
          ),
          SizedBox(height: widget.height * 0.02),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is ShowPasswordState) {
                widget.isPasswordVisible = state.isPasswordVisible;
              } else if (state is HidePasswordState) {
                widget.isPasswordVisible = state.isPasswordVisible;
              }
            },
            builder: (context, state) {
              return CustomTextFormField(
                onSave: (value) {},
                controller: passwordController,
                toggelPasswordFunction: () {
                  BlocProvider.of<AuthBloc>(context)
                      .add(ToggelPasswordVisibilityEvent());
                },
                isPasswordVisible: widget.isPasswordVisible,
                isPasswordField: true,
                focusNode: _passwordFocusNode,
                text: 'Password',
                hint: '* * * * * * ',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password Can\'t be Empty';
                  }
                },
              );
            },
          ),
          SizedBox(height: widget.height * 0.05),
          CustomButton(
            onPress: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState?.save();

                final authEntity = AuthEntity(
                    email: emailController.text,
                    password: passwordController.text);

                BlocProvider.of<AuthBloc>(context)
                    .add(EmailAndPasswordLogInEvent(authEntity: authEntity));
              }
            },
            text: 'SIGN IN',
          ),
          SizedBox(height: widget.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: 'Don\'t have an account, ',
                alignment: Alignment.center,
                fontFamily: 'Ubuntu-Light',
                fontSize: 13,
              ),
              SizedBox(width: widget.width * 0.03),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const SignUpView(),
                  ));
                },
                child: const CustomText(
                  text: 'sign up here',
                  color: Colors.blue,
                  alignment: Alignment.center,
                  fontFamily: 'Ubuntu-Medium',
                  fontSize: 13,
                ),
              ),
            ],
          ),
          SizedBox(height: widget.height * 0.02),
          const CustomText(
            text: '-OR-',
            alignment: Alignment.center,
            fontSize: 14,
          ),
          SizedBox(height: widget.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButtonLogo(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(GoogleLogInEvent());
                },
                imageName: 'assets/images/google.png',
              ),
              CustomButtonLogo(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(FacebookLogInEvent());
                },
                imageName: 'assets/images/facebook.png',
              ),
              CustomButtonLogo(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const GetPhoneNumberView(),
                  ));
                },
                iconData: Icons.phone,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
