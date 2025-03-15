import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';

class UserEntity {
  final String id;
  final String name;
  final String email;
  final String imageUrl;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  factory UserEntity.fromDataModel(UserDataModel dataModel) {
    return UserEntity(
      id: dataModel.id,
      name: dataModel.name,
      email: dataModel.email,
      imageUrl: dataModel.imageUrl,
    );
  }

  UserDataModel toDataModel() {
    return UserDataModel(
      id: id,
      name: name,
      email: email,
      imageUrl: imageUrl,
    );
  }
}
