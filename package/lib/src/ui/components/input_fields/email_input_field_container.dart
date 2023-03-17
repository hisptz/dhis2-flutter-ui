// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dhis2_flutter_ui/src/ui/utils/entry_form_util.dart';
import 'package:flutter/material.dart';

import '../../models/input_field.dart';

/// `EmailInputFieldContainer` is a class for the email input field container
class EmailInputFieldContainer extends StatefulWidget {
  /// `InputField` is the input field metadata for the email inputs
  final InputField inputField;

  /// `Function` callback called when the input value has changed
  final Function onInputValueChange;

  /// `Function` callback for setting validation errors when email validations have failed
  final Function setValidationError;

  /// `String` value for the email input field
  final String? inputValue;

  ///
  ///  this is the default constructor for `EmailInputFieldContainer`
  /// the constructor accepts `InputField` metadata, `String` value, a callback `Function` that is called when the value changed and a callback `Function` to set validation error messaged
  ///
  const EmailInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    required this.setValidationError,
    this.inputValue,
  }) : super(key: key);

  @override
  State<EmailInputFieldContainer> createState() =>
      _EmailInputFieldContainerState();
}

class _EmailInputFieldContainerState extends State<EmailInputFieldContainer> {
  TextEditingController? emailController;

  @override
  void initState() {
    super.initState();
    setState(() {});
    updateEmailValue(value: widget.inputValue);
  }

  updateEmailValue({String? value = ''}) {
    emailController = TextEditingController(text: value);
    setState(() {});
  }

  String getSanitizedNumericalValue(String value) {
    value = value.trim() == '' ? '0' : value;
    return !value.contains('.')
        ? '${int.parse(value)}'
        : '${double.parse(value)}';
  }

  void onValueChange(String value) {
    bool isValidEmail = EntryFormUtil.isEmailValid(value..trim());
    widget.onInputValueChange(value.trim());
    isValidEmail
        ? widget.setValidationError(false)
        : widget.setValidationError(true);
  }

  @override
  void didUpdateWidget(covariant EmailInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) {
      if (widget.inputField.isReadOnly!) {
        updateEmailValue(value: widget.inputValue);
      }
      if (widget.inputValue == null || widget.inputValue == '') {
        updateEmailValue();
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
                : emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: onValueChange,
            style: const TextStyle().copyWith(
              color: widget.inputField.inputColor,
            ),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.inputField.hint!,
              errorText: null,
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 20.0,
                minHeight: 20.0,
              ),
              suffixIcon: Visibility(
                visible: widget.inputField.suffixLabel != '',
                child: Text(
                  widget.inputField.suffixLabel ?? '',
                  style: const TextStyle().copyWith(
                    color: widget.inputField.inputColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
