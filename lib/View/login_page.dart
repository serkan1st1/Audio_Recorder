import 'package:audio_recorder/utils/generalColors.dart';
import 'package:audio_recorder/utils/generalTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String email, password;

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
                  ],
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
      "Merhaba,\nHoşgeldin",
      style: GeneralTextStyle.titleTextStyle,
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz";
        }
      },
      onSaved: (value) {
        email = value!;
      },
      style: TextStyle(color: Colors.white),
      decoration: generalInputDecoration("Email"),
    );
  }

  TextFormField passwordTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Bilgileri Eksiksiz Doldurunuz";
        }
      },
      onSaved: (value) {
        password = value!;
      },
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: generalInputDecoration("Şifre"),
    );
  }

  Center signUpButton() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, "/signUp"),
        child: generalText(
          "Kayıt Ol",
          GeneralColors.textButtonColor,
        ),
      ),
    );
  }

  Center signInButton() {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Container(
          height: 50,
          width: 150,
          margin: EdgeInsets.symmetric(horizontal: 60),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Color(0xff31274F),
          ),
          child: Center(
            child: generalText("Giriş Yap", GeneralColors.loginButtonTextColor),
          ),
        ),
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
