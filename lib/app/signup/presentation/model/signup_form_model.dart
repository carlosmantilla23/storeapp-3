final class SignupFormModel {
  final String email;
  final String password;
  final String image;
  final String name;

  SignupFormModel(
      {required this.email,
      required this.password,
      required this.image,
      required this.name});

  SignupFormModel copyWith({required String email}) {
    return SignupFormModel(
        email: email, password: password, image: image, name: name);
  }
}
