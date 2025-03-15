import 'package:dio/dio.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';

class UserService {
  final Dio dio;
  final String _baseUrl =
      "https://storeapp-3e889-default-rtdb.firebaseio.com/users.json";

  UserService({required this.dio});

  Future<List<UserEntity>> getAllUsers() async {
    try {
      final response = await dio.get(_baseUrl);
      final List<UserEntity> users = [];

      if (response.data != null) {
        response.data.forEach((key, value) {
          users.add(UserDataModel.fromJson(value, key).toEntity());
        });
      }
      return users;
    } catch (e) {
      throw Exception("Error al obtener usuarios: $e");
    }
  }

  Future<void> addUser(UserEntity user) async {
    try {
      await dio.put(
        "https://storeapp-3e889-default-rtdb.firebaseio.com/users/${user.id}.json",
        data: UserDataModel.fromEntity(user).toJson(),
      );
    } catch (e) {
      throw Exception("Error al agregar usuario: $e");
    }
  }
}
