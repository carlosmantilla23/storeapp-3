import 'package:storeapp/app/signup/presentation/model/signup_form_model.dart';

sealed class SignUpState {
  SignUpState({required this.model});

  final SignupFormModel model;
}

class InitialSignUpState extends SignUpState {
  InitialSignUpState()
      : super(
            model:
                SignupFormModel(email: "", password: "", image: "", name: ""));
}

class LoadingSignUpState extends SignUpState {
  LoadingSignUpState({required super.model});
}

class SuccessSignUpState extends SignUpState {
  SuccessSignUpState({required super.model});
}

class ErrorSignUpState extends SignUpState {
  ErrorSignUpState({required super.model, required this.message});
  final String message;
}

final class DataUpdateState extends SignUpState {
  DataUpdateState({required super.model});
}
