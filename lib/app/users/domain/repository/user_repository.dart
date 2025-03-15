import 'package:storeapp/app/core/domain/entity/user_entity.dart';

abstract class UserRepository {
  Future<List<UserEntity>> getUsers();
  Future<void> addUser(UserEntity user);
}
