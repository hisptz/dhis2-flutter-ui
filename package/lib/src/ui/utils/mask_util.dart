import 'package:flutter/services.dart';

class InputMask extends TextInputFormatter {
  final String pattern;
  final String separator;
  final String placeholder = "";
  InputMask({required this.pattern, required this.separator});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length >= pattern.length) {
        int offset = newValue.text.length > pattern.length
            ? pattern.length
            : newValue.selection.baseOffset;
        return getFormatText(TextEditingValue(
            text: newValue.text.substring(0, pattern.length),
            selection:
                TextSelection.fromPosition(TextPosition(offset: offset))));
      }

      if (newValue.text.length < pattern.length &&
          pattern[newValue.text.length - 1] == separator) {
        return getFormatText(newValue);
      }
    }
    return newValue;
  }

  TextEditingValue getFormatText(TextEditingValue newValue) {
    int offset = newValue.selection.end;
    String text = List.generate(pattern.length, (index) {
      if (pattern[index] == separator) {
        if (index < newValue.text.length && newValue.text[index] != separator) {
          offset += 1;
          return "$separator${newValue.text[index]}";
        }
        return separator;
      }

      return index < newValue.text.length
          ? newValue.text[index] == separator
              ? placeholder
              : newValue.text[index]
          : placeholder;
    }).join();

    return TextEditingValue(
        text: text,
        selection: TextSelection.fromPosition(TextPosition(offset: offset)));
  }
}
