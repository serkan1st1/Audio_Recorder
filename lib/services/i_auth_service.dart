import '../model/user_model.dart';

abstract class IAuthService {
  Future<UserModel> createUserEmailAndPassword(
      {required String email, required String password});

  Future<UserModel> signInEmailAndPassword(
      {required String email, required String password});

  Future<void> signOut();

  Stream<UserModel?> get onAuthStateChanged;
}
