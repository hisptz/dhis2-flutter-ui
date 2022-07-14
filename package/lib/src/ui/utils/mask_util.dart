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
      if (newValue.text.length > pattern.length) {
        return getFormatText(TextEditingValue(
            text: newValue.text.substring(0, pattern.length),
            selection: newValue.selection));
      }

      if (newValue.text.length < pattern.length &&
          pattern[newValue.text.length - 1] == separator) {
        return getFormatText(newValue);
      }
    }
    return newValue;
  }

  TextEditingValue getFormatText(TextEditingValue newValue) {
    String text = List.generate(pattern.length, (index) {
      if (pattern[index] == separator) {
        String char = (newValue.selection.baseOffset > 0
                ? newValue.text.substring(newValue.selection.extentOffset - 1)
                : placeholder)
            .replaceAll(separator, "");

        return newValue.selection.baseOffset - 1 == index
            ? "$separator$char"
            : separator;
      }

      return index < newValue.text.length
          ? newValue.text[index] == separator
              ? placeholder
              : newValue.text[index]
          : placeholder;
    }).join();

    int offset = newValue.selection.end < pattern.length
        ? newValue.selection.end + 1
        : newValue.selection.end;

    return TextEditingValue(
        text: text,
        selection: TextSelection.fromPosition(TextPosition(offset: offset)));
  }
}
