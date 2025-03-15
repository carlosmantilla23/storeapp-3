import 'package:storeapp/app/core/domain/entity/user_entity.dart';

class UserDataModel {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json, String id) {
    return UserDataModel(
      id: id,
      name: json["name"] ?? "Sin nombre",
      email: json["email"] ?? "Sin correo",
      imageUrl: json["imageUrl"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "imageUrl": imageUrl,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      imageUrl: imageUrl,
    );
  }

  factory UserDataModel.fromEntity(UserEntity entity) {
    return UserDataModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      imageUrl: entity.imageUrl,
    );
  }
}
