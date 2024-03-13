// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/input_field.dart';
import '../../models/validators.dart';

// `TextInputFieldContainer` is the input field container for a text field
class TextInputFieldContainer extends StatefulWidget {
  // `InputField` is the input field metadata for a text field
  final InputField inputField;

  // `Function` callback called when input values had changed
  final Function? onInputValueChange;

  // `String` value for the input field
  final String? inputValue;

  // `bool` variable to indicate wether or not a check icon for text input should be shown
  final bool showInputCheckedIcon;

  // `List` of `FormValidator` for the text input field
  final List<FormValidator>? validators;

  // `List` of the `TextInputFormatter` for the text input field
  final List<TextInputFormatter>? inputFormatters;

  //
  // this is a default constructor for the `TextInputFieldContainer`
  // the constructor accepts `InputField` metadata, `String` value, `List<FormValidator>` of form validators, a callback `Function` that is called when the value changed and a `List<TextInputFormatter>` of text field formatters
  //
  const TextInputFieldContainer({
    Key? key,
    required this.inputField,
    this.onInputValueChange,
    this.inputValue,
    this.showInputCheckedIcon = true,
    this.validators,
    this.inputFormatters,
  }) : super(key: key);
  @override
  State<TextInputFieldContainer> createState() =>
      _TextInputFieldContainerState();
}

class _TextInputFieldContainerState extends State<TextInputFieldContainer> {
  TextEditingController? textController;
  String? _value;
  String? _lastInputValue = '';
  bool? _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _value = widget.inputValue;
    _isPasswordVisible = !widget.inputField.isPasswordField!;
    setState(() {});
    updateTextValue(value: widget.inputValue);
  }

  updateTextValue({String? value = ''}) {
    _value = value;
    setState(() {});
    textController = TextEditingController(text: value);
  }

  onValueChange(String value) {
    if (_lastInputValue != value) {
      setState(() {
        _value = value;
        _lastInputValue = _value;
      });
      widget.onInputValueChange!(value.trim());
    }
  }

  _updatePasswordVisibilityStatus() {
    _isPasswordVisible = !_isPasswordVisible!;
    setState(() {});
  }

  clearSearchValue() {
    updateTextValue();
    widget.onInputValueChange!(_value);
  }

  @override
  void didUpdateWidget(covariant TextInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) {
      if (widget.inputField.isReadOnly!) {
        updateTextValue(value: widget.inputValue);
      }
      if (widget.inputValue == null || widget.inputValue == '') {
        updateTextValue();
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
                : textController,
            maxLength: widget.inputField.maxLength,
            onChanged: onValueChange,
            inputFormatters: widget.inputFormatters,
            maxLines: widget.inputField.valueType == 'LONG_TEXT' ? null : 1,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            obscureText: !_isPasswordVisible!,
            textCapitalization: widget.inputField.shouldCapitalize!
                ? TextCapitalization.sentences
                : TextCapitalization.none,
            style: const TextStyle().copyWith(
              color: widget.inputField.inputColor,
            ),
            decoration: InputDecoration(
              hintText: widget.inputField.hint ?? '',
              border: InputBorder.none,
              errorText: null,
              prefixIcon: Visibility(
                visible: widget.inputField.prefixLabel != '',
                child: Text(
                  widget.inputField.prefixLabel ?? '',
                  style: const TextStyle().copyWith(
                    color: widget.inputField.inputColor,
                  ),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(
                maxHeight: 16.0,
                minHeight: 16.0,
              ),
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 20.0,
                minHeight: 20.0,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    visible: widget.inputField.suffixLabel != '' &&
                        _value != null &&
                        '$_value'.trim() != '',
                    child: Text(
                      widget.inputField.suffixLabel ?? '',
                      style: const TextStyle().copyWith(
                        color: widget.inputField.inputColor,
                      ),
                    ),
                  ),
                  Container(
                    child: !widget.inputField.isPasswordField!
                        ? null
                        : Container(
                            margin: EdgeInsets.only(
                              right: _value != null && '$_value'.trim() != ''
                                  ? 0.0
                                  : 5.0,
                            ),
                            child: GestureDetector(
                              onTap: _updatePasswordVisibilityStatus,
                              child: Container(
                                color: widget.inputField.inputColor!
                                    .withOpacity(0.01),
                                child: SvgPicture.asset(
                                  _isPasswordVisible!
                                      ? 'assets/icons/login-close-eye.svg'
                                      : 'assets/icons/login-open-eye.svg',
                                  colorFilter: ColorFilter.mode(
                                    widget.inputField.inputColor!,
                                    BlendMode.srcATop,
                                  ),
                                  package: 'dhis2_flutter_ui',
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
