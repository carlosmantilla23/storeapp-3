import 'package:storeapp/app/users/domain/repository/user_repository.dart';
import 'package:storeapp/app/core/domain/entity/user_entity.dart';

class GetUsersUseCase {
  final UserRepository repository;

  GetUsersUseCase({required this.repository});

  Future<List<UserEntity>> call() async {
    return await repository.getUsers();
  }
}
