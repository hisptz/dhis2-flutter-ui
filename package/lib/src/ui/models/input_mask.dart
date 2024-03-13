// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/services.dart';

//
// `Pattern` is the type definition for the pattern that is a function that accepts an `int` separator index
//
typedef Pattern = Function(int separatorIndex);

//
// `InputMask` is a class that extends the `TextInputFormatter` class
// The class allows adding masking on the input fields
//
class InputMask extends TextInputFormatter {
  // This is a `String` pattern for the input mask
  final String pattern;

  // This is a `String` separator signs for the input mask
  final String separator;

  /// This is a `String` for the placeholder
  final String placeholder = '';

  //  This is the default constructor for `InputMask` class
  InputMask({
    required this.pattern,
    required this.separator,
  });

  //
  // `formatEditUpdate` is the function for applying the mask on input value changes
  // @params: oldValue : `TextEditingValue` for the old value for the input field
  // @params: newValue :  `TextEditingValue` for the new value of the input field
  //
  // @return: the function returns a `TextEditingValue`
  //
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length >= pattern.length) {
        String text = transformText(
          text: newValue.text,
        );
        int offset = getOffset(
          oldValue,
          newValue,
          text,
        );

        return TextEditingValue(
          text: text.substring(0, pattern.length),
          selection: TextSelection.fromPosition(
            TextPosition(
              offset: offset,
            ),
          ),
        );
      }

      if (newValue.text.length < pattern.length) {
        return getFormatText(oldValue, newValue);
      }
    }
    return newValue;
  }

  //
  // `getFormatText` is the function for getting the formatted text
  // @params: oldValue : `TextEditingValue` for the old value for the input field
  // @params: newValue :  `TextEditingValue` for the new value of the input field
  //
  // @return: the function returns `TextEditingValue` formatted value
  //
  TextEditingValue getFormatText(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    int offset = newValue.selection.baseOffset;

    String text = transformText(
        text: newValue.text,
        onPattern: (int separatorIndex) =>
            separatorIndex + 1 == offset ? offset += 1 : offset);

    return TextEditingValue(
      text: text,
      selection: TextSelection.fromPosition(
        TextPosition(
          offset: offset >= pattern.length ? pattern.length : offset,
        ),
      ),
    );
  }

  //
  // `getFormatText` is the function for getting the formatted text
  // @params: text : `String` value for the text to be transformed
  // @params: pattern :  `Pattern` for transforming the text
  //
  // @return: the function returns the transformed `String` value
  //
  String transformText({required String text, Pattern? onPattern}) {
    return List.generate(pattern.length, (index) {
      if (pattern[index] == separator) {
        if (index < text.length && text[index] != separator) {
          if (onPattern != null) onPattern(index);
          return '$separator${text[index]}';
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

  //
  //  `getOffset` is the function for getting the offset for a text value between the old and new value
  //   @params: oldValue : `TextEditingValue` for the old value for the input field
  //   @params: newValue :  `TextEditingValue` for the new value for the input field
  //   @params: text : `String` text whose offset needs evaluations
  //
  //   @return: the function returns `int` offset for the text
  //
  int getOffset(
    TextEditingValue oldValue,
    TextEditingValue newValue,
    String text,
  ) {
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
