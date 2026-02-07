import 'package:flutter_flavors_boilerplate/utils/validations/validations.dart';

extension BooleanExtensions on bool {
  /// Type: `bool.not() -> bool`
  ///
  /// Inverts the given boolean value.
  ///
  /// This function accepts a boolean value and returns it's
  /// inverted value
  ///
  /// Returns:
  ///   `true` returns `false` and
  ///   `false` returns `true`
  bool not() => !this;
}

extension StringExtensions on String {
  /// Checks if the given string contains any non-digit characters.
  /// Returns `true` if any non-digit characters are found, otherwise returns `false`.
  bool containsLetter() => Validations.containsAnyLetter(this);

  /// Reverses the string.
  ///
  /// Uses the `codeUnits` property to get the `UTF-16` code units of the string.
  /// The `reversed` getter creates an iterable of the code units in reverse order.
  /// The `String.fromCharCodes` constructor then creates a string from the reversed code units.
  ///
  /// Returns:
  ///   A new string with the characters of the original string in reverse order.
  String reverse() => String.fromCharCodes(codeUnits.reversed);

  String concat(String word) => '$this$word';
}

// datetime extensions
extension DateTimeExtensions on DateTime {
  bool isBeforeOrEqual(DateTime date) =>
      isBefore(date) || isAtSameMomentAs(date);

  bool isAfterOrEqual(DateTime date) => isAfter(date) || isAtSameMomentAs(date);
}
