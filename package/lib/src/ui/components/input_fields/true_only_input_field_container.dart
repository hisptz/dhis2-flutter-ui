// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/cupertino.dart';

import '../../models/input_field.dart';

///
/// `TrueOnlyInputFieldContainer` is a class for true only input fields containers
///
class TrueOnlyInputFieldContainer extends StatefulWidget {
  /// `InputField` is the input field metadata
  final InputField inputField;

  /// `bool` to indicate wether or not the input label should be shown
  final bool hideInputLabel;

  /// a callback `Function` called when the input value has changed
  final Function onInputValueChange;

  /// a `dynamic` value for the true only input container
  final dynamic inputValue;

  ///
  /// this is a default constructor for the `TrueOnlyInputFieldContainer`
  /// the constructor accepts an `InputField`, `dynamic` input value, a callback `Function` when an input changed, and `bool` that decides wether or not a label should be displayed
  ///
  const TrueOnlyInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    this.inputValue,
    this.hideInputLabel = false,
  }) : super(key: key);

  @override
  _TrueOnlyInputFieldContainerState createState() =>
      _TrueOnlyInputFieldContainerState();
}

class _TrueOnlyInputFieldContainerState
    extends State<TrueOnlyInputFieldContainer> {
  late bool _value;
  String? _switchLabel;
  Color inActiveColor = const Color(0xFF737373);
  String yesLabel = 'Yes';
  String noLabel = 'Yes';

  @override
  void initState() {
    super.initState();
    updateInputValueState();
  }

  updateInputValueState() {
    bool value = false;
    value = '${widget.inputValue}' == 'true' ? true : false;
    onSetValue(value);
  }

  @override
  void didUpdateWidget(covariant TrueOnlyInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) updateInputValueState();
  }

  onSetValue(bool value) {
    setState(() {
      _value = value;
      _switchLabel = value ? yesLabel : noLabel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Visibility(
          visible: !widget.hideInputLabel,
          child: Container(
            width: 30.0,
            margin: const EdgeInsets.only(
              left: 5.0,
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 1.0,
            ),
            child: Text(
              '$_switchLabel',
              style: const TextStyle().copyWith(
                fontSize: 12.0,
                color: _value ? widget.inputField.inputColor : inActiveColor,
              ),
            ),
          ),
        ),
        CupertinoSwitch(
          activeColor: widget.inputField.inputColor,
          trackColor: inActiveColor,
          value: _value,
          onChanged: widget.inputField.isReadOnly!
              ? null
              : (bool value) {
                  onSetValue(value);
                  widget.onInputValueChange(
                    value ? value : '',
                  );
                },
        ),
      ],
    );
  }
}
