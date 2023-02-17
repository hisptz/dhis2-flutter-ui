// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

///
/// `CheckBoxInputField` is a widget for rendering check box inputs
///
class CheckBoxInputField extends StatefulWidget {
  /// this is a `Function` that is called when the input value has changed
  final Function onInputValueChange;

  /// this is a `String` label for a check box
  final String? label;

  /// this is a `Color` for when the input is checked
  final Color? color;

  /// this is a `dynamic` value for the check box
  final dynamic value;

  /// this is a `bool` that indicates wether the check box is readonly or not
  final bool isReadOnly;

  ///
  /// this is a default constructor for the check box input fields
  /// the constructor takes the label, value, color, readonly decision and a function for when the value is changed
  ///
  const CheckBoxInputField({
    Key? key,
    required this.onInputValueChange,
    required this.label,
    required this.value,
    required this.color,
    required this.isReadOnly,
  }) : super(key: key);

  @override
  _CheckBoxInputFieldState createState() => _CheckBoxInputFieldState();
}

class _CheckBoxInputFieldState extends State<CheckBoxInputField> {
  bool? _inputValue;

  @override
  void initState() {
    super.initState();
    updateInputValueState();
  }

  /// this function is called when the the input value is changed
  updateInputValueState() {
    setState(() {
      _inputValue = widget.value != null && '${widget.value}' == 'true';
    });
  }

  @override
  void didUpdateWidget(covariant CheckBoxInputField oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.value != widget.value) updateInputValueState();
  }

  void onInputValueChange(bool? value) {
    updateInputValueState();
    widget.onInputValueChange(value == true ? value : null);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _inputValue,
          activeColor: _inputValue! ? widget.color : null,
          checkColor: _inputValue! ? Colors.white : null,
          onChanged: widget.isReadOnly ? null : onInputValueChange,
        ),
        Expanded(
          child: Text(
            widget.label!,
            style: const TextStyle().copyWith(
              color: _inputValue! ? widget.color : null,
            ),
          ),
        ),
      ],
    );
  }
}
