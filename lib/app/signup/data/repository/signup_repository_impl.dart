import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/signup/domain/entity/signup_entity.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';

class SignUpRepositoryImpl implements SignupRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Dio dio;

  SignUpRepositoryImpl({required this.dio});

  @override
  Future<bool> registerUser(SignUpEntity signupEntity) async {
    try {
      print("Intentando registrar usuario con Firebase...");
      print("Email: ${signupEntity.email}");
      print("Password: ${signupEntity.password}");

      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: signupEntity.email,
        password: signupEntity.password,
      );

      String userId = userCredential.user!.uid;

      print("Usuario registrado en Firebase con ID: $userId");

      UserEntity newUser = UserEntity(
        id: userId,
        name: signupEntity.name,
        email: signupEntity.email,
        imageUrl: signupEntity.imageUrl,
      );

      print("Guardando usuario en Realtime Database...");
      await dio.put(
        "https://storeapp-3e889-default-rtdb.firebaseio.com/users/$userId.json",
        data: UserDataModel.fromEntity(newUser).toJson(),
      );

      print("Usuario guardado en Realtime Database correctamente.");

      return true;
    } catch (e) {
      print("Error al registrar usuario: $e");
      return false;
    }
  }
}
