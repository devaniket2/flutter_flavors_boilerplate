sealed class Validations {
  Validations._();

  static final RegExp _phoneValidator = RegExp(r'^[0-9]{4,15}$');
  static final RegExp _emailValidator = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,15}$',
  );
  static final _hasAnyLettersValidator = RegExp(r'\D');
  static final _containsAnyNumberValidator = RegExp(r'\d');
  static final _containsAnyLowerCaseValidator = RegExp(r'[a-z]');
  static final _containsAnyUpperCaseValidator = RegExp(r'[A-Z]');
  static final _containsAnySpecialCaseValidator = RegExp(r'[!@#$%^&*]');

  static bool isValidPhoneNumber(String number) =>
      _phoneValidator.hasMatch(number);

  static bool isValidEmail(String email) => _emailValidator.hasMatch(email);

  static bool containsAnyLetter(String word) =>
      _hasAnyLettersValidator.hasMatch(word);

  static bool containsAnyNumber(String word) =>
      _containsAnyNumberValidator.hasMatch(word);

  static bool containsAnyLowerCaseLetter(String word) =>
      _containsAnyLowerCaseValidator.hasMatch(word);

  static bool containsAnyUpperCaseLetter(String word) =>
      _containsAnyUpperCaseValidator.hasMatch(word);

  static bool containsAnySpecialLetter(String word) =>
      _containsAnySpecialCaseValidator.hasMatch(word);
}
