import 'package:storeapp/app/login/domain/entity/login_entity.dart';
import 'package:storeapp/app/login/domain/repository/login_repository.dart';
import 'package:storeapp/app/login/presentation/model/login_form_model.dart';

class LoginUseCase {
  late final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  Future<bool> invoke(LoginFormModel loginFormModel) {
    final LoginEntity data = loginFormModel.toEntity();

    return loginRepository.login(data);
  }
}
