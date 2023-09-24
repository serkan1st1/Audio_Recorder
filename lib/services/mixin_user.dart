import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';

mixin ConvertUser {
  UserModel convertUser(UserCredential user) {
    return UserModel(userId: user.user!.uid, userMail: user.user!.email!);
  }
}
