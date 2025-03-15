mixin SignupMixin {
  String? validatedPassword(String? value, String? confirmPassword) {
    value ??= "";
    confirmPassword ??= "";

    value = value.replaceAll(" ", "");
    confirmPassword = confirmPassword.replaceAll(" ", "");

    if (value.length < 8) {
      return "La contraseña debe tener al menos 8 caracteres";
    }

    if (value != confirmPassword) {
      return "Las contraseñas no coinciden";
    }

    return null;
  }

  String? validatedEmail(String? value) {
    value ??= "";
    value = value.replaceAll(" ", "");
    final bool isValid = RegExp(
            r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$")
        .hasMatch(value);
    return !isValid ? "Email inválido" : null;
  }
}
