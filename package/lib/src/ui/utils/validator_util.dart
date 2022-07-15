typedef FormValidator = dynamic Function();

class Validators {
  static FormValidator pattern(String regex, String? message) => () => {
        "pattern": () => [regex, message]
      };
}

extension Validator on String? {
  String? validate(List<FormValidator>? validators) {
    return validators
        ?.map((e) {
          final validator = e.call();
          if (validator != null) {
            if (validator is Map) {
              if (validator["pattern"] != null) {
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
    final List<String?> pattern = validator["pattern"].call();

    if (pattern.isEmpty) return null;

    return RegExp(pattern[0] as String).hasMatch(this as String)
        ? null
        : (pattern.length > 1)
            ? pattern[1]
            : pattern[0];
  }
}
