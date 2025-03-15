import 'package:storeapp/app/core/domain/entity/user_entity.dart';

sealed class UserEvent {}

class GetUsersEvent extends UserEvent {}

class AddUserEvent extends UserEvent {
  final UserEntity user;
  AddUserEvent({required this.user});
}
