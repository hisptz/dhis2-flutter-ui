// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../models/input_field.dart';

// `NumericalInputFieldContainer` is an input field container for numerical input fields
class NumericalInputFieldContainer extends StatefulWidget {
  // `InputField` metadata for the numerical input field container
  final InputField inputField;

  // `Function` callback called when input values had changed
  final Function onInputValueChange;

  // `String` value for the numerical field
  final String? inputValue;

  //
  // this is a default constructor for `NumericalInputFieldContainer`
  // the constructor accepts `String` value for the numerical field, `Function` callback called when input values had changed and `InputField` metadata for the numerical input field container
  //
  const NumericalInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    this.inputValue,
  }) : super(key: key);

  @override
  State<NumericalInputFieldContainer> createState() =>
      _NumericalInputFieldContainerState();
}

class _NumericalInputFieldContainerState
    extends State<NumericalInputFieldContainer> {
  TextEditingController? numericalController;

  @override
  void initState() {
    super.initState();
    setState(() {});
    updateNumericalValue(value: widget.inputValue);
  }

  updateNumericalValue({String? value = ''}) {
    numericalController = TextEditingController(text: value);
    setState(() {});
  }

  String getSanitizedNumericalValue(String value) {
    value = value.trim() == '' ? '0' : value;
    return !value.contains('.')
        ? '${int.parse(value)}'
        : '${double.parse(value)}';
  }

  void onValueChange(String value) {
    String sanitizedValue = getSanitizedNumericalValue(value);
    setState(() {});
    widget.onInputValueChange(sanitizedValue.trim());
  }

  @override
  void didUpdateWidget(covariant NumericalInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) {
      if (widget.inputField.isReadOnly!) {
        updateNumericalValue(value: widget.inputValue);
      }
      if (widget.inputValue == null || widget.inputValue == '') {
        updateNumericalValue();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            readOnly: widget.inputField.isReadOnly!,
            controller: widget.inputField.isReadOnly!
                ? TextEditingController(
                    text: widget.inputValue,
                  )
                : numericalController,
            keyboardType: TextInputType.number,
            onChanged: onValueChange,
            style: const TextStyle().copyWith(
              color: widget.inputField.inputColor,
            ),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.inputField.hint!,
              errorText: null,
            ),
          ),
        ),
      ],
    );
  }
}
