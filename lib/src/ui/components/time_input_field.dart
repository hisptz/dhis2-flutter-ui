import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/utils/app_util.dart';
import 'package:flutter/material.dart';

class TimeInputFieldContainer extends StatefulWidget {
  const TimeInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    this.inputValue,
  }) : super(key: key);

  final InputField inputField;
  final Function onInputValueChange;
  final String? inputValue;

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
        _time ?? AppUtil.formattedTimeOfDayIntoString(TimeOfDay.now());
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
      initialTime: AppUtil.getTimeIntoDTimeOfDayFormat(time),
      initialEntryMode: TimePickerEntryMode.dial,
      confirmText: 'Ok',
      cancelText: 'Cancel',
      helpText: widget.inputField.hint ?? widget.inputField.name,
      errorInvalidText: 'Enter ${widget.inputField.name} in valid time',
    );
    if (timeOfDay != null) {
      setState(() {
        _time = AppUtil.formattedTimeOfDayIntoString(timeOfDay);
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
