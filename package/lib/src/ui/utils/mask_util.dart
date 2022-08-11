import 'package:flutter/services.dart';

typedef Pattern = Function(int separatorIndex);

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
        String text = transformText(text: newValue.text);
        int offset = getOffset(oldValue, newValue, text);

        return TextEditingValue(
            text: text.substring(0, pattern.length),
            selection:
                TextSelection.fromPosition(TextPosition(offset: offset)));
      }

      if (newValue.text.length < pattern.length) {
        return getFormatText(oldValue, newValue);
      }
    }
    return newValue;
  }

  TextEditingValue getFormatText(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int offset = newValue.selection.baseOffset;

    String text = transformText(
        text: newValue.text,
        onPattern: (int separatorIndex) =>
            separatorIndex + 1 == offset ? offset += 1 : offset);

    return TextEditingValue(
        text: text,
        selection: TextSelection.fromPosition(TextPosition(
            offset: offset >= pattern.length ? pattern.length : offset)));
  }

  String transformText({required String text, Pattern? onPattern}) {
    return List.generate(pattern.length, (index) {
      if (pattern[index] == separator) {
        if (index < text.length && text[index] != separator) {
          if (onPattern != null) onPattern(index);
          return "$separator${text[index]}";
        }
        return separator;
      }

      return index < text.length
          ? text[index] == separator
              ? placeholder
              : text[index]
          : placeholder;
    }).join();
  }

  getOffset(TextEditingValue oldValue, TextEditingValue newValue, String text) {
    int newOffset = newValue.selection.baseOffset;
    int oldOffset = oldValue.selection.baseOffset;

    if (text.length - 1 > newOffset &&
        (text[newOffset] == separator || text[newOffset - 1] == separator)) {
      return newOffset + 1;
    }

    if (oldOffset < newOffset && newOffset >= pattern.length - 1) {
      return pattern.length;
    }

    return newOffset;
  }
}
