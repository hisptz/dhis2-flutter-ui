// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../models/input_field.dart';
import '../../models/input_field_option.dart';
import 'check_box_input_field_container.dart';

///
/// `CheckBoxListInputField` this is a container widget for displaying a list of check box inputs
///
class CheckBoxListInputField extends StatefulWidget {
  /// `InputField` is the input field metadata for the checkbox input
  final InputField inputField;

  /// `Map` key values pair for the values of the form object
  final Map dataObject;

  /// `Function` callback called when input values had changed
  final Function? onInputValueChange;

  /// `bool` value to show whether the values are to be rendered as readonly or not
  final bool isReadOnly;

  ///
  /// this is the default constructor for the `CheckBoxListInputField`
  /// the parameter accepts `InputField` metadata, `Map` form data objects, `bool` readonly indicators and `Function` callback
  ///
  const CheckBoxListInputField({
    Key? key,
    required this.inputField,
    required this.dataObject,
    this.isReadOnly = false,
    this.onInputValueChange,
  }) : super(key: key);

  @override
  State<CheckBoxListInputField> createState() => _CheckBoxListInputFieldState();
}

class _CheckBoxListInputFieldState extends State<CheckBoxListInputField> {
  final Map _inputValue = {};

  @override
  void initState() {
    super.initState();
    updateInputValueState();
  }

  updateInputValueState() {
    for (InputFieldOption option in widget.inputField.options!) {
      _inputValue[option.code] = widget.dataObject[option.code] ?? false;
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant CheckBoxListInputField oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.dataObject != widget.dataObject) updateInputValueState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.inputField.options!
            .map(
              (InputFieldOption option) => CheckBoxInputFieldContainer(
                isReadOnly: widget.isReadOnly,
                label: option.name,
                value: widget.dataObject[option.code],
                color: widget.inputField.inputColor,
                onInputValueChange: (dynamic value) =>
                    widget.onInputValueChange!(option.code, '$value'),
              ),
            )
            .toList(),
      ),
    );
  }
}
