import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:flutter/material.dart';

class PercentageInputFieldContainer extends StatefulWidget {
  const PercentageInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    required this.setValidationError,
    this.inputValue,
  }) : super(key: key);

  final InputField inputField;
  final Function onInputValueChange;
  final Function setValidationError;
  final String? inputValue;

  @override
  State<PercentageInputFieldContainer> createState() =>
      _PercentageInputFieldContainerState();
}

class _PercentageInputFieldContainerState
    extends State<PercentageInputFieldContainer> {
  TextEditingController? percentageController;

  @override
  void initState() {
    super.initState();
    updatePercentageValue(value: widget.inputValue);
  }

  updatePercentageValue({String? value = ''}) {
    percentageController = TextEditingController(text: value);
    setState(() {});
  }

  void onValueChange(String value) {
    widget.setValidationError(false);
    if (value.isNotEmpty) {
      try {
        double percentageValue = double.parse(value);
        if (percentageValue >= 0 && percentageValue <= 100) {
          widget.setValidationError(false);
          widget.onInputValueChange(percentageValue.toString());
        } else {
          widget.setValidationError(true);
        }
      } catch (e) {
        //
        widget.setValidationError(true);
      }
    }
  }

  @override
  void didUpdateWidget(covariant PercentageInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) {
      if (widget.inputField.isReadOnly!) {
        updatePercentageValue(value: widget.inputValue);
      }
      if (widget.inputValue == null || widget.inputValue == '') {
        updatePercentageValue();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    percentageController = null;
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
                : percentageController,
            keyboardType: TextInputType.number,
            onChanged: onValueChange,
            style: const TextStyle().copyWith(
              color: widget.inputField.inputColor,
            ),
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.inputField.hint!,
              errorText: null,
            ),
          ),
        ),
      ],
    );
  }
}
