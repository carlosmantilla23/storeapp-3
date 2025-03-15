import 'package:storeapp/app/signup/domain/entity/signup_entity.dart';
import 'package:storeapp/app/signup/domain/repository/signup_repository.dart';

class SignUpUseCase {
  final SignupRepository signUpRepository;

  SignUpUseCase({required this.signUpRepository});

  Future<bool> invoke(SignUpEntity signupEntity) {
    return signUpRepository.registerUser(signupEntity);
  }
}
