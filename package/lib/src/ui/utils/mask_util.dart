import 'package:flutter/services.dart';

class InputMask extends TextInputFormatter {
  final String pattern;
  final String separator;

  InputMask({required this.pattern, required this.separator});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > pattern.length) return oldValue;
      if (newValue.text.length < pattern.length &&
          pattern[newValue.text.length - 1] == separator) {
        return TextEditingValue(
            text:
                "${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}",
            selection:
                TextSelection.collapsed(offset: newValue.selection.end + 1));
      }
    }

    return newValue;
  }
}
