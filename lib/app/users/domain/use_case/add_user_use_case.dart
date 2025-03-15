import 'package:storeapp/app/users/domain/repository/user_repository.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';

class AddUserUseCase {
  final UserRepository repository;

  AddUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return await repository.addUser(user);
  }
}
