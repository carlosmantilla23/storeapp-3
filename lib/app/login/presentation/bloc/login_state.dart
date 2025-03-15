import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

sealed class LoginState {
  LoginState({required this.model});

  final LoginFormModel model;
}

class InitialState extends LoginState {
  InitialState() : super(model: LoginFormModel(email: "", password: ""));
}

final class DataUpdateState extends LoginState {
  DataUpdateState({required super.model});
}

final class LoginSuccessState extends LoginState {
  LoginSuccessState({required super.model});
}

final class LoginErrorState extends LoginState {
  LoginErrorState({required super.model, required this.message});
  final String message;
}
