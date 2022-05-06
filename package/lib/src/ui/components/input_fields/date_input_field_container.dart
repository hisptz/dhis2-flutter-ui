import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/utils/app_util.dart';
import 'package:flutter/material.dart';

class DateInputFieldContainer extends StatefulWidget {
  const DateInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    this.inputValue,
  }) : super(key: key);
  final InputField inputField;
  final Function onInputValueChange;
  final String? inputValue;

  @override
  _DateInputFieldContainerState createState() =>
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
        resetDate();
      }
    }
  }

  resetDate() {
    setState(() {
      _date = null;
      dateController = TextEditingController(text: _date);
    });
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
    int minAgeInYear = widget.inputField.minAgeInYear ?? limit;
    int maxAgeInYear = widget.inputField.maxAgeInYear ?? -limit;
    DateTime lastDate = getDateFromGivenYear(
        widget.inputField.minAgeInYear != null ? minAgeInYear : -limit);
    DateTime firstDate = getDateFromGivenYear(
        widget.inputField.maxAgeInYear != null ? maxAgeInYear : limit,
        numberOfMonth: widget.inputField.numberOfMonth != null
            ? widget.inputField.numberOfMonth! + 1
            : 0,
        numberOfDays: 1);
    DateTime currentDate = DateTime.now();
    int numberOfYearBetweenCurrentAndMaxDate = currentDate.year - lastDate.year;
    _date = _date ??
        AppUtil.formattedDateTimeIntoString(
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
      initialDate: AppUtil.getDateIntoDateTimeFormat(_date!),
      firstDate:
          widget.inputField.disablePastPeriod! ? DateTime.now() : firstDate,
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
        _date = AppUtil.formattedDateTimeIntoString(date);
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
