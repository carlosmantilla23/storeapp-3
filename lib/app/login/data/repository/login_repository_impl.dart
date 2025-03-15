import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<bool> login(LoginEntity loginEntity) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: loginEntity.email,
        password: loginEntity.password,
      );

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool("isLoggedIn", true);
      await prefs.setString("user_email", userCredential.user?.email ?? "");
      await prefs.setString("user_id", userCredential.user?.uid ?? "");

      return true;
    } on FirebaseAuthException catch (e) {
      print("Error en login: ${e.message}");
      return false;
    }

  }

  Future<void> logout() async {
    // TODO: implement logout
    await _firebaseAuth.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
