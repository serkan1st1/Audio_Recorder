import 'package:audio_recorder/View/login_page.dart';
import 'package:audio_recorder/model/user_model.dart';
import 'package:flutter/material.dart';

import '../View/home_page.dart';

class AuthRoute extends StatelessWidget {
  const AuthRoute({super.key, required this.snapShot});
  final AsyncSnapshot<UserModel?> snapShot;
  @override
  Widget build(BuildContext context) {
    if (snapShot.connectionState == ConnectionState.active) {
      return snapShot.hasData ? HomePage() : const LoginPage();
    }
    return ErrorPage();
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: const Text("An error occurred")),
    );
  }
}
