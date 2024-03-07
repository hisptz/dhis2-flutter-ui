// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../models/input_field.dart';

// `PercentageInputFieldContainer` is a container for the percentage input fields
class PercentageInputFieldContainer extends StatefulWidget {
  // `InputField` is the input field metadata for the percentage input field container
  final InputField inputField;

  // `Function` callback called when input values had changed
  final Function onInputValueChange;

  // `Function` callback called to set validation errors
  final Function setValidationError;

  // `String` value for the percentage input field
  final String? inputValue;

  //
  // this is the default constructor for the `PercentageInputFieldContainer`
  //  the constructor accepts `Function` callback called to set validation errors, `InputField` that is the input field metadata, `Function` callback called when input values had changed and a `String` value for the percentage input field
  //
  const PercentageInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    required this.setValidationError,
    this.inputValue,
  }) : super(key: key);

  @override
  State<PercentageInputFieldContainer> createState() =>
      _PercentageInputFieldContainerState();
}

class _PercentageInputFieldContainerState
    extends State<PercentageInputFieldContainer> {
  TextEditingController? percentageController;

  @override
  void initState() {
    super.initState();
    updatePercentageValue(value: widget.inputValue);
  }

  updatePercentageValue({String? value = ''}) {
    percentageController = TextEditingController(text: value);
    setState(() {});
  }

  void onValueChange(String value) {
    widget.setValidationError(false);
    if (value.isNotEmpty) {
      try {
        double percentageValue = double.parse(value);
        if (percentageValue >= 0 && percentageValue <= 100) {
          widget.setValidationError(false);
          widget.onInputValueChange(percentageValue.toString());
        } else {
          widget.setValidationError(true);
        }
      } catch (e) {
        //
        widget.setValidationError(true);
      }
    }
  }

  @override
  void didUpdateWidget(covariant PercentageInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) {
      if (widget.inputField.isReadOnly!) {
        updatePercentageValue(value: widget.inputValue);
      }
      if (widget.inputValue == null || widget.inputValue == '') {
        updatePercentageValue();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    percentageController = null;
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
                : percentageController,
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
