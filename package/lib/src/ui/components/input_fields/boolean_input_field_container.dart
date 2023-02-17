// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../models/input_field.dart';
import '../../models/input_field_option.dart';
import 'radio_input_field_container.dart';

///
/// `BooleanInputFieldContainer` is a container widget for the Boolean inputs.
///
class BooleanInputFieldContainer extends StatefulWidget {
  /// this is the `InputField` object that described the metadata for input field
  final InputField inputField;

  /// this is the `Function` that gets called when the input value has changed
  final Function onInputValueChange;

  /// this is a `dynamic` value for the `BooleanInputFieldContainer`
  final dynamic inputValue;

  ///
  /// this is a default constructor for the `BooleanInputFieldContainer`
  /// it accepts the input field object, input value and a handler function for when the value change
  ///
  const BooleanInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    this.inputValue,
  }) : super(key: key);

  @override
  _BooleanInputFieldContainerState createState() =>
      _BooleanInputFieldContainerState();
}

class _BooleanInputFieldContainerState
    extends State<BooleanInputFieldContainer> {
  ///
  /// This is the list of `InputFieldOption` that are used as boolean in DHIS2
  ///
  final List<InputFieldOption> options = [
    InputFieldOption(
      name: 'Yes',
      translatedName: 'Yes',
      code: true,
    ),
    InputFieldOption(
      name: 'No',
      translatedName: 'No',
      code: false,
    ),
  ];
  bool? _inputValue;

  @override
  void initState() {
    super.initState();
    _updateInputFieldState();
  }

  /// this is the function that updates the state of the input value
  _updateInputFieldState() {
    setState(() {
      _inputValue =
          widget.inputValue != null && '${widget.inputValue}' == 'true'
              ? true
              : widget.inputValue != null && '${widget.inputValue}' == 'false'
                  ? false
                  : null;
    });
  }

  @override
  void didUpdateWidget(
    covariant BooleanInputFieldContainer oldWidget,
  ) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) _updateInputFieldState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return RadioInputFieldContainer(
      options: options,
      isReadOnly: widget.inputField.isReadOnly,
      activeColor: widget.inputField.inputColor,
      currentValue: _inputValue,
      onInputValueChange: widget.onInputValueChange,
    );
  }
}
