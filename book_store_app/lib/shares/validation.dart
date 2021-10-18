class Validation {
  static isEmailValid(String email) {
    final regexEmail = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regexEmail.hasMatch(email);
  }

  static isNameValid(String name) {
    final regexName = RegExp('[a-zA-Z]');
    return regexName.hasMatch(name);
  }

  static isPhoneValid(String phone) {
    final regexPhone = RegExp(r'^[0-9]+$');
    return regexPhone.hasMatch(phone);
  }

  static isPassword(String password) {
    return password.length > 6;
  }
}
