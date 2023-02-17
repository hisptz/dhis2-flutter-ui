// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../models/input_field.dart';
import '../../utils/entry_form_util.dart';

/// `DateInputFieldContainer` is a class for the date input field container
class DateInputFieldContainer extends StatefulWidget {
  /// `InputField` is the input field metadata for the date input field container
  final InputField inputField;

  /// `Function` callback called when input values had changed
  final Function onInputValueChange;

  /// `String` value for the date input field
  final String? inputValue;

  ///
  /// this is the default constructor for the `DateInputFieldContainer`
  /// the constructor accepts `InputField` metadata, `String` value and a callback `Function` that is called when the value changed
  ///
  const DateInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    this.inputValue,
  }) : super(key: key);

  @override
  State<DateInputFieldContainer> createState() =>
      _DateInputFieldContainerState();
}

class _DateInputFieldContainerState extends State<DateInputFieldContainer> {
  TextEditingController? dateController;

  String? _date;

  @override
  void initState() {
    super.initState();
    setState(() {
      _date = widget.inputValue == '' ? null : widget.inputValue;
      dateController = TextEditingController(text: _date);
    });
  }

  @override
  void didUpdateWidget(covariant DateInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) {
      if (widget.inputValue == null || widget.inputValue == '') {
        resetDate(null);
      } else {
        resetDate(widget.inputValue);
      }
    }
  }

  resetDate(dynamic value) {
    _date = value;
    dateController = TextEditingController(text: _date);
    setState(() {});
  }

  DateTime getDateFromGivenYear(int year,
      {int numberOfMonth = 0, int numberOfDays = 0}) {
    DateTime currentDate = DateTime.now();
    return DateTime(
      currentDate.year - year,
      currentDate.month - numberOfMonth,
      currentDate.day + numberOfDays,
    );
  }

  void onOpenDateSelection(BuildContext context) async {
    int limit = 200;
    int minYear = widget.inputField.minYear ?? limit;
    int maxYear = widget.inputField.maxYear ?? -limit;
    DateTime lastDate = widget.inputField.maxDate ??
        getDateFromGivenYear(
            widget.inputField.maxYear != null ? maxYear : -limit);
    DateTime firstDate = widget.inputField.minDate ??
        getDateFromGivenYear(
            widget.inputField.minYear != null ? minYear : limit,
            numberOfMonth: widget.inputField.numberOfMonth != null
                ? widget.inputField.numberOfMonth! + 1
                : 0,
            numberOfDays: 1);
    DateTime currentDate = DateTime.now();
    int numberOfYearBetweenCurrentAndMaxDate = currentDate.year - lastDate.year;
    _date = _date ??
        EntryFormUtil.formattedDateTimeIntoString(
          numberOfYearBetweenCurrentAndMaxDate >= 0 ? lastDate : currentDate,
        );
    DateTime? date = await showDatePicker(
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
      fieldLabelText: widget.inputField.name,
      initialDate: EntryFormUtil.getDateIntoDateTimeFormat(_date!),
      firstDate: widget.inputField.disablePastPeriod! &&
              widget.inputField.minDate == null
          ? DateTime.now()
          : firstDate,
      confirmText: 'Ok',
      cancelText: 'Cancel',
      lastDate: widget.inputField.allowFuturePeriod! ||
              numberOfYearBetweenCurrentAndMaxDate >= 0
          ? lastDate
          : DateTime.now(),
      helpText: widget.inputField.hint ?? widget.inputField.name,
      errorFormatText: 'Enter valid ${widget.inputField.name}',
      errorInvalidText: 'Enter ${widget.inputField.name} in valid range',
    );

    if (date != null) {
      setState(() {
        _date = EntryFormUtil.formattedDateTimeIntoString(date);
        dateController = TextEditingController(text: _date);
        widget.onInputValueChange(_date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: dateController,
            style: const TextStyle().copyWith(
              color: widget.inputField.inputColor,
            ),
            onTap: () => widget.inputField.isReadOnly!
                ? null
                : onOpenDateSelection(context),
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
