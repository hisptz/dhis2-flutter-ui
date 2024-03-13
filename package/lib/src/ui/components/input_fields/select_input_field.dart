// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:dhis2_flutter_ui/src/main_directive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// `SelectInputField` is a select input field for rendering selectable options
class SelectInputField extends StatefulWidget {
  // `Color` for the select
  final Color? color;

  // `bool` to show wether or not a select input is readonly
  final bool? isReadOnly;

  //  `List<InputFieldOption>` that is a list of options on the select input
  final List<InputFieldOption>? options;

  // `dynamic` value of the selected option
  final dynamic selectedOption;

  // `Function` callback called when input values had changed
  final Function onInputValueChange;

  // `bool` to show wether or not a select input is rendered as radio
  final bool? renderAsRadio;

  // `Map` if input field options that are hidden
  //  example `{"inputId": true}`
  //
  final Map hiddenInputFieldOptions;

  //
  // this is a default constructor for the `SelectInputField`
  // the constructor accepts `List<InputFieldOption>`, `dynamic` selected value, `bool` to show if input is readonly, `bool` if the input is rendered as radio and `Map` of hidden options
  //
  //
  const SelectInputField({
    Key? key,
    this.color,
    required this.options,
    required this.selectedOption,
    required this.onInputValueChange,
    required this.isReadOnly,
    required this.hiddenInputFieldOptions,
    this.renderAsRadio,
  }) : super(key: key);

  @override
  State<SelectInputField> createState() => _SelectInputFieldState();
}

class _SelectInputFieldState extends State<SelectInputField> {
  dynamic _selectedOption;
  Map _hiddenInputFieldOptions = {};
  List<InputFieldOption>? _options;

  @override
  void initState() {
    super.initState();
    updateInputValueState(widget.selectedOption);
  }

  updateInputValueState(dynamic value) {
    _hiddenInputFieldOptions = widget.hiddenInputFieldOptions;
    _options = widget.options!.where((InputFieldOption option) {
      return _hiddenInputFieldOptions[option.code] == null ||
          (_hiddenInputFieldOptions[option.code] != null &&
              '${_hiddenInputFieldOptions[option.code]}' != 'true');
    }).toList();
    setState(() {
      _selectedOption = value == '' ? null : value;
    });
  }

  @override
  void didUpdateWidget(covariant SelectInputField oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.selectedOption != widget.selectedOption ||
        oldWidget.hiddenInputFieldOptions != widget.hiddenInputFieldOptions ||
        oldWidget.options != widget.options) {
      updateInputValueState(widget.selectedOption);
    }
  }

  void onValueChange(dynamic value) {
    widget.onInputValueChange(value);
    updateInputValueState(value);
  }

  @override
  Widget build(BuildContext context) {
    return widget.renderAsRadio!
        ? RadioInputFieldContainer(
            options: _options,
            isReadOnly: widget.isReadOnly,
            currentValue: _selectedOption,
            activeColor: widget.color,
            onInputValueChange: widget.onInputValueChange,
          )
        : SelectionOptionContainer(
            selectedOption: _selectedOption,
            options: _options,
            onValueChange: onValueChange,
            color: widget.color,
            isReadOnly: widget.isReadOnly,
          );
  }
}

class SelectionOptionContainer extends StatelessWidget {
  const SelectionOptionContainer({
    Key? key,
    required selectedOption,
    required List<InputFieldOption>? options,
    this.color,
    this.isReadOnly,
    this.onValueChange,
  })  : _selectedOption = selectedOption,
        _options = options,
        super(key: key);

  final dynamic _selectedOption;
  final List<InputFieldOption>? _options;
  final Color? color;
  final bool? isReadOnly;
  final Function? onValueChange;
  @override
  Widget build(BuildContext context) {
    void onChange(value) {
      FocusScope.of(context).requestFocus(FocusNode());
      onValueChange!(value);
    }

    return Row(
      children: [
        Expanded(
          child: DropdownButton<dynamic>(
            value: _selectedOption,
            isExpanded: true,
            icon: SizedBox(
              height: 20.0,
              child: SvgPicture.asset(
                'assets/icons/chevron_down.svg',
                colorFilter: ColorFilter.mode(
                  color ?? Colors.black,
                  BlendMode.srcATop,
                ),
                package: 'dhis2_flutter_ui',
              ),
            ),
            elevation: 16,
            style: TextStyle(color: color ?? Colors.black),
            underline: Container(
              height: 0,
              color: Colors.transparent,
            ),
            onChanged: isReadOnly! ? null : onChange,
            disabledHint: Text(
              _selectedOption ?? '',
              style: TextStyle(color: color),
            ),
            items: _options!.map<DropdownMenuItem<dynamic>>(
              (InputFieldOption option) {
                return DropdownMenuItem<dynamic>(
                  value: option.code,
                  child: Text(
                    option.name,
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
