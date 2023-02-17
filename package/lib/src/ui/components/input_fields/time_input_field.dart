// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../models/input_field.dart';
import '../../utils/entry_form_util.dart';

///
/// `TimeInputFieldContainer` is an input field container for time
///
class TimeInputFieldContainer extends StatefulWidget {
  /// `InputField` is the input field metadata for the time input
  final InputField inputField;

  /// `Function` callback called when input values had changed
  final Function onInputValueChange;

  /// `String` value of the time input
  final String? inputValue;

  /// `String` value for the invalid time error message
  final String? errorInvalidText;

  /// this is  a default constructor for the `TimeInputFieldContainer`
  const TimeInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    this.inputValue,
    this.errorInvalidText,
  }) : super(key: key);

  @override
  State<TimeInputFieldContainer> createState() =>
      _TimeInputFieldContainerState();
}

class _TimeInputFieldContainerState extends State<TimeInputFieldContainer> {
  TextEditingController? timeController;

  String? _time;

  @override
  void initState() {
    super.initState();
    setState(() {
      _time = widget.inputValue == '' ? null : widget.inputValue;
      timeController = TextEditingController(text: _time);
    });
  }

  @override
  void didUpdateWidget(covariant TimeInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) {
      if (widget.inputValue == null || widget.inputValue == '') {
        resetDate();
      }
    }
  }

  resetDate() {
    setState(() {
      _time = null;
      timeController = TextEditingController(text: _time);
    });
  }

  onOpenTimeSelection(BuildContext context) async {
    String time =
        _time ?? EntryFormUtil.formattedTimeOfDayIntoString(TimeOfDay.now());
    final TimeOfDay? timeOfDay = await showTimePicker(
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light().copyWith(
              primary: widget.inputField.inputColor,
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialTime: EntryFormUtil.getTimeIntoDTimeOfDayFormat(time),
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: 'Ok',
      cancelText: 'Cancel',
      helpText: widget.inputField.hint ?? widget.inputField.name,
      errorInvalidText: widget.errorInvalidText ??
          'Enter ${widget.inputField.name} in valid time',
    );
    if (timeOfDay != null) {
      setState(() {
        _time = EntryFormUtil.formattedTimeOfDayIntoString(timeOfDay);
        timeController = TextEditingController(text: _time);
        widget.onInputValueChange(_time);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: timeController,
            style: const TextStyle().copyWith(
              color: widget.inputField.inputColor,
            ),
            onTap: () => widget.inputField.isReadOnly!
                ? null
                : onOpenTimeSelection(context),
            readOnly: true,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.inputField.hint,
              errorText: null,
            ),
          ),
        ),
      ],
    );
  }
}
