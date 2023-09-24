import 'package:audio_recorder/model/user_model.dart';
import 'package:audio_recorder/services/i_auth_service.dart';
import 'package:audio_recorder/services/mixin_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService with ConvertUser implements IAuthService {
  final FirebaseAuth _authInstance = FirebaseAuth.instance;

  UserModel _getUser(User? user) {
    return UserModel(userId: user!.uid, userMail: user.email!);
  }

  @override
  Future<UserModel> createUserEmailAndPassword(
      {required String email, required String password}) async {
    var _tempUser = await _authInstance.createUserWithEmailAndPassword(
        email: email, password: password);
    return convertUser(_tempUser);
  }

  @override
  Stream<UserModel?> get onAuthStateChanged =>
      _authInstance.authStateChanges().map(_getUser);

  @override
  Future<UserModel> signInEmailAndPassword(
      {required String email, required String password}) async {
    var _tempUser = await _authInstance.signInWithEmailAndPassword(
        email: email, password: password);
    return convertUser(_tempUser);
  }

  @override
  Future<void> signOut() async {
    await _authInstance.signOut();
  }
}
