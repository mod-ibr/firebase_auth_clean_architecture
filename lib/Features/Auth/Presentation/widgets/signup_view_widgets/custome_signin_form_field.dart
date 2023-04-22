import 'package:flutter/material.dart';
import '../../../../../Core/Utils/Functions/snackbar_message.dart';
import '../../../../../Core/Widgets/loading_widget.dart';
import '../../../../../home_view.dart';
import '../../../Domain/Entites/auth_entity.dart';
import '../../view_model/auth/auth_bloc.dart';
import '../../widgets/authWidgets/custom_button.dart';
import '../../widgets/authWidgets/custom_text.dart';
import '../../widgets/authWidgets/custom_text_form_field.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view/loginView/login_view.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/widgets/authWidgets/logo_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class CustomeSignUpFormField extends StatefulWidget {
  final double width, height;
  bool isPasswordVisible = false;

  CustomeSignUpFormField(
      {super.key, required this.height, required this.width});

  @override
  State<CustomeSignUpFormField> createState() => _CustomeSignUpFormFieldState();
}

class _CustomeSignUpFormFieldState extends State<CustomeSignUpFormField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
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
    _userNameController.dispose();
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
            userNameController: _userNameController,
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
      required TextEditingController userNameController,
      required FocusNode emailFocusNode,
      required FocusNode passwordFocusNode,
      required GlobalKey<FormState> formKey}) {
    return Form(
      key: formKey,
      child: ListView(
        children: [
          //Logo
          const LogoWidget(title: 'Create A New Account'),
          SizedBox(height: widget.width * 0.15),
          CustomTextFormField(
            isPasswordField: false,
            controller: userNameController,
            text: 'Name',
            hint: 'Example',
            onSave: (value) {},
            validator: (value) {
              if (value!.isEmpty) {
                return 'Name Can\'t be Empty';
              }
            },
          ),
          SizedBox(height: widget.width * 0.03),
          CustomTextFormField(
            controller: emailController,
            isPasswordField: false,
            text: 'Email',
            hint: 'example@gmail.com',
            onSave: (value) {},
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email Can\'t be Empty';
              } else if (!value!.toString().contains('@') ||
                  value!.length < 12 ||
                  value!.length > 35) {
                return 'Invalid Email';
              }
            },
          ),
          SizedBox(height: widget.width * 0.03),
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
          SizedBox(height: widget.width * 0.08),
          CustomButton(
            onPress: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState?.save();
                final authEntity = AuthEntity(
                    userName: userNameController.text,
                    email: emailController.text,
                    password: passwordController.text);

                BlocProvider.of<AuthBloc>(context)
                    .add(CreateAccountEvent(authEntity: authEntity));
              }
            },
            text: 'Next',
          ),
          SizedBox(height: widget.width * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomText(
                text: 'have an account, ',
                alignment: Alignment.center,
                fontFamily: 'Ubuntu-Light',
                fontSize: 13,
              ),
              SizedBox(width: widget.width * 0.03),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LogInView(),
                  ));
                },
                child: const CustomText(
                  text: 'Log in here',
                  color: Colors.blue,
                  alignment: Alignment.center,
                  fontFamily: 'Ubuntu-Medium',
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
