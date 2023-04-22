import 'package:firebase_auth_clean_arch/Core/Widgets/loading_widget.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view/loginView/login_view.dart';
import 'package:firebase_auth_clean_arch/Features/Auth/Presentation/view_model/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Features/Auth/Presentation/widgets/authWidgets/logo_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SucceededAuthState) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LogInView()));
        }
      },
      builder: (context, state) {
        if (state is LoadingAuthState) {
          return const LoadingWidget();
        }
        return Scaffold(
            appBar: AppBar(
              title: const Text('HomePage'),
            ),
            body: homeViewBody(context: context, height: height, width: width));
      },
    );
  }

  Widget homeViewBody(
      {required BuildContext context,
      required double width,
      required double height}) {
    return Container(
      padding: EdgeInsets.only(
          left: width * 0.03,
          right: width * 0.03,
          bottom: width * 0.03,
          top: width * 0.1),
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const LogoWidget(title: 'Home Page'),
          const SizedBox(height: 50),
          ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(color: Colors.black, width: 2),
                ),
              ),
            ),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogOutEvent());
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            label: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
