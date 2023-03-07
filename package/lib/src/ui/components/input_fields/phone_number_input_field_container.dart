// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dhis2_flutter_ui/src/ui/utils/entry_form_util.dart';
import 'package:flutter/material.dart';

import '../../models/input_field.dart';

class PhoneNumberInputFieldContainer extends StatefulWidget {
  /// `InputField` is the input field metadata for the phone number input field container
  final InputField inputField;

  /// `Function` callback called when input values had changed
  final Function onInputValueChange;

  /// `Function` callback called when value is either valid or not for set validation error
  final Function setValidationError;

  /// `String` value for the phone number field
  final String? inputValue;

  ///
  /// this is a default constructor for the `PhoneNumberInputFieldContainer`
  /// the constructor accepts `String` value for the phone number field, `Function` callback called when input values had changed and  `InputField` metadata
  const PhoneNumberInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    required this.setValidationError,
    this.inputValue,
  }) : super(key: key);

  @override
  State<PhoneNumberInputFieldContainer> createState() =>
      _PhoneNumberInputFieldContainerState();
}

class _PhoneNumberInputFieldContainerState
    extends State<PhoneNumberInputFieldContainer> {
  TextEditingController? phoneNumberController;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController(text: widget.inputValue);
  }

  void onValueChange(String value) {
    bool isValidPhoneNumber = EntryFormUtil.isPhoneNumberValid(value..trim());
    widget.setValidationError(false);
    if (isValidPhoneNumber) {
      widget.setValidationError(false);
      widget.onInputValueChange(value.trim());
    } else {
      widget.setValidationError(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            readOnly: widget.inputField.isReadOnly!,
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
            onChanged: onValueChange,
            style: const TextStyle().copyWith(
              color: widget.inputField.inputColor,
            ),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.inputField.hint,
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
