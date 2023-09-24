import 'package:audio_recorder/services/google_service.dart';
import 'package:audio_recorder/utils/generalColors.dart';
import 'package:audio_recorder/utils/generalTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/i_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String Email, Password;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 34, 39, 76),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * .25,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/topImage.png"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleText(),
                      generalSizedBox(),
                      emailTextField(),
                      generalSizedBox(),
                      passwordTextField(),
                      generalSizedBox(),
                      signUpButton(),
                      generalSizedBox(),
                      signInButton(),
                      generalSizedBox(),
                      googleSignInButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Text titleText() {
    return const Text(
      "Hi,\nWelcome",
      style: GeneralTextStyle.titleTextStyle,
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Email can't be black";
        }
      },
      onSaved: (value) {
        Email = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: generalInputDecoration("Email"),
    );
  }

  TextFormField passwordTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Password can't be blank";
        }
      },
      onSaved: (value) {
        Password = value!;
      },
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: generalInputDecoration("Password"),
    );
  }

  Center signUpButton() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, "/signUp"),
        child: generalText(
          "Sign Up",
          GeneralColors.textButtonColor,
        ),
      ),
    );
  }

  Center signInButton() {
    final authService = Provider.of<IAuthService>(context, listen: false);
    return Center(
      child: TextButton(
        onPressed: () {
          signIn(authService);
        },
        child: Container(
          height: 50,
          width: 150,
          margin: EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xff31274F),
          ),
          child: Center(
            child: generalText("Sign In", GeneralColors.loginButtonTextColor),
          ),
        ),
      ),
    );
  }

  Future<void> signIn(IAuthService authService) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    try {
      await authService.signInEmailAndPassword(
          email: Email, password: Password);
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Email or password is incorrect'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Okey'),
              ),
            ],
          );
        },
      );
    }
  }

  Center googleSignInButton() {
    return Center(
      child: InkWell(
        onTap: () {
          GoogleService().signInWithGoogle().then(
                (value) => Navigator.pushNamed(context, "/home"),
              );
        },
        child: Image.asset('assets/images/google.png'),
      ),
    );
  }

  Widget generalSizedBox() => const SizedBox(
        height: 20,
      );

  Widget generalText(String text, Color color) => Text(
        text,
        style: TextStyle(color: color),
      );

  InputDecoration generalInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
    );
  }
}
