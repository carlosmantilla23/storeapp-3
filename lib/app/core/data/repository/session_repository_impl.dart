import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storeapp/app/core/domain/repository/session_repository.dart';

final class SessionRepositoryImpl implements SessionRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> logout() async {
    try {
      await _firebaseAuth.signOut();
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove("isLoggedIn");
    } catch (e) {
      print("Error al cerrar sesión: $e");
      return false;
    }
  }
}
