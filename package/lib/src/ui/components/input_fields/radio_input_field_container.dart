// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../models/input_field_option.dart';

/// `RadioInputFieldContainer` is the radio input field container
class RadioInputFieldContainer extends StatefulWidget {
  ///  `List<InputFieldOption>` that is a list of options on the radio input
  final List<InputFieldOption>? options;

  /// `dynamic` value of the selected option
  final dynamic currentValue;

  /// `Function` callback called when input values had changed
  final Function onInputValueChange;

  /// `Color` for the actively selected option
  final Color? activeColor;

  /// `bool` to show wether or not a select input is rendered as readonly
  final bool? isReadOnly;

  ///
  /// this is the default constructor for the `RadioInputFieldContainer`
  ///  the constructor accepts inputs for `Function` callback called when input values had changed, `dynamic` value of the selected option, `bool` to show wether or not a select input is rendered as readonly, `Color` for the actively selected option and `List<InputFieldOption>` that is a list of options on the radio input
  ///
  const RadioInputFieldContainer({
    Key? key,
    required this.options,
    required this.currentValue,
    required this.onInputValueChange,
    required this.isReadOnly,
    this.activeColor,
  }) : super(key: key);

  @override
  _RadioInputFieldContainerState createState() =>
      _RadioInputFieldContainerState();
}

class _RadioInputFieldContainerState extends State<RadioInputFieldContainer> {
  dynamic _currentValue;

  @override
  void initState() {
    super.initState();
    updateInputFieldState();
  }

  updateInputFieldState() {
    setState(() {
      _currentValue = widget.currentValue;
    });
  }

  @override
  void didUpdateWidget(covariant RadioInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.currentValue != widget.currentValue) updateInputFieldState();
  }

  void setSelectedOption(dynamic value) {
    updateInputFieldState();
    widget.onInputValueChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      child: Wrap(
        children: widget.options!
            .map(
              (InputFieldOption option) => Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    activeColor: widget.activeColor,
                    value: option.code,
                    groupValue: _currentValue,
                    onChanged: widget.isReadOnly! ? null : setSelectedOption,
                  ),
                  Text(
                    option.name,
                    style: const TextStyle().copyWith(
                      color: _currentValue == option.code
                          ? widget.activeColor
                          : null,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
