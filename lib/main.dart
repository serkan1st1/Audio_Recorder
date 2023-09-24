import 'package:audio_recorder/View/home_page.dart';
import 'package:audio_recorder/View/sign_up_page.dart';
import 'package:audio_recorder/Widgets/auth_widget_builder.dart';
import 'package:audio_recorder/services/auth_service.dart';
import 'package:audio_recorder/services/i_auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'View/login_page.dart';
import 'Widgets/auth_route_widget.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'model/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IAuthService>(
          create: (_) => AuthService(),
        )
      ],
      child: AuthWidgetBuilder(
        onPageBuilder: (context, AsyncSnapshot<UserModel?> snapShot) =>
            MaterialApp(
          title: 'Flutter Audio Recorder',
          debugShowCheckedModeBanner: false,
          routes: {
            "/loginPage": (context) => LoginPage(),
            "/signUp": (context) => SignUpPage(),
            "/home": (context) => HomePage(),
          },
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: AuthRoute(
            snapShot: snapShot,
          ),
        ),
      ),
    );
  }
}
