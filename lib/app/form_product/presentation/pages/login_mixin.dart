mixin LoginMixin {
  String? validatedPassword(String? value) {
    // value = value ?? "";
    value ??= "";
    value.replaceAll(" ", "");
    if (value.length < 8) {
      return "Constraseña inválida";
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
