import 'package:storeapp/app/core/domain/entity/user_entity.dart';

sealed class UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final List<UserEntity> users;
  UserLoadedState({required this.users});
}

class UserErrorState extends UserState {
  final String message;
  UserErrorState({required this.message});
}

class UserEmptyState extends UserState {}
