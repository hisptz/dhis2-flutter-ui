// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

///
/// This is the type definition for `FormValidator`
///
typedef FormValidator = dynamic Function();

///
/// This is the class for the `Validators` for the form
///
class Validators {
  ///
  /// This is the static method for formatting the form validator
  ///  @params: regex: is a `String` representation of the validation regular expression
  ///  @params: message: is a `String` validation message.
  ///
  ///  @return: the method return the `FormValidator` function
  ///
  static FormValidator pattern(String regex, String? message) => () => {
        'pattern': () => [regex, message]
      };
}

///
/// `Validator` is the extension to the `String` class for allowing validation functionality
///
extension Validator on String? {
  ///
  ///  `validate` method validates the given form validators
  ///  @params: validators : `List` of form validator functions to be evaluated
  ///
  String? validate(List<FormValidator>? validators) {
    return validators
        ?.map((e) {
          final validator = e.call();
          if (validator != null) {
            if (validator is Map) {
              if (validator['pattern'] != null) {
                return () => _pattern(validator);
              }
            }
            return validator.call();
          }
          return validator;
        })
        .firstWhere((element) => element != null)
        ?.call();
  }

  _pattern(Map validator) {
    final List<String?> pattern = validator['pattern'].call();

    if (pattern.isEmpty) return null;

    return RegExp(pattern[0] as String).hasMatch(this as String)
        ? null
        : (pattern.length > 1)
            ? pattern[1]
            : pattern[0];
  }
}
