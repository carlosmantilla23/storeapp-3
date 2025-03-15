import 'package:storeapp/app/signup/domain/entity/signup_entity.dart';

abstract class SignupRepository {
  Future<bool> registerUser(SignUpEntity signupEntity);
}
