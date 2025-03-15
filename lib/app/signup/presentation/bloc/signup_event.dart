import 'package:storeapp/app/signup/domain/entity/signup_entity.dart';

sealed class SignUpEvent {}

final class EmailChangedEvent extends SignUpEvent {
  final String email;
  EmailChangedEvent({required this.email});
}

final class SubmitSignUpEvent extends SignUpEvent {
  final SignUpEntity signupEntity;
  SubmitSignUpEvent({required this.signupEntity});
}
