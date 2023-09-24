import 'package:audio_recorder/services/i_auth_service.dart';
import 'package:audio_recorder/utils/generalColors.dart';
import 'package:audio_recorder/utils/generalTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late String email, password;
  final formKey = GlobalKey<FormState>();

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
                  key: formKey,
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
                      backToLoginPageButton(),
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
      "Create User",
      style: GeneralTextStyle.titleTextStyle,
    );
  }

  TextFormField emailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "Email can't be blank ";
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
          return "Password can't be blank";
        }
      },
      onSaved: (value) {
        password = value!;
      },
      obscureText: true,
      style: TextStyle(color: Colors.white),
      decoration: generalInputDecoration("Password"),
    );
  }

  Center backToLoginPageButton() {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.pushNamed(context, "/loginPage"),
        child: generalText(
          "Turn Back",
          GeneralColors.textButtonColor,
        ),
      ),
    );
  }

  Center signUpButton() {
    final authService = Provider.of<IAuthService>(context, listen: false);
    return Center(
      child: TextButton(
        onPressed: () {
          CreateUser(authService);
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
            child: generalText("Sign Up", GeneralColors.loginButtonTextColor),
          ),
        ),
      ),
    );
  }

  void CreateUser(IAuthService authService) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      try {
        await authService.createUserEmailAndPassword(
            email: email, password: password);
        formKey.currentState!.reset();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Welcome"),
          ),
        );
      } catch (e) {
        print(e.toString());
      }
    }
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
