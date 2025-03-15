import 'package:storeapp/app/core/data/remote/service/user_service.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';
import 'package:storeapp/app/users/domain/repository/user_repository.dart';
import 'package:storeapp/app/core/data/remote/dto/user_data_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService userService;

  UserRepositoryImpl({required this.userService});

  @override
  Future<List<UserEntity>> getUsers() async {
    final usersDataModel = await userService.getAllUsers();

    return usersDataModel.map((userDataModel) {
      return UserEntity(
        id: userDataModel.id,
        name: userDataModel.name,
        email: userDataModel.email,
        imageUrl: userDataModel.imageUrl,
      );
    }).toList();
  }

  @override
  Future<void> addUser(UserEntity user) async {
    final userDataModel = UserDataModel(
      id: user.id,
      name: user.name,
      email: user.email,
      imageUrl: user.imageUrl,
    );

    await userService.addUser(userDataModel as UserEntity);
  }
}
