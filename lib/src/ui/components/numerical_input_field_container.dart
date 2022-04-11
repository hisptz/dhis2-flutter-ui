import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:flutter/material.dart';

class NumericalInputFieldContainer extends StatefulWidget {
  const NumericalInputFieldContainer(
      {Key? key,
      required this.inputField,
      required this.onInputValueChange,
      this.inputValue})
      : super(key: key);

  final InputField inputField;
  final Function onInputValueChange;
  final String? inputValue;

  @override
  _NumericalInputFieldContainerState createState() =>
      _NumericalInputFieldContainerState();
}

class _NumericalInputFieldContainerState
    extends State<NumericalInputFieldContainer> {
  TextEditingController? numericalController;

  @override
  void initState() {
    super.initState();
    setState(() {});
    updateNumericalValue(value: widget.inputValue);
  }

  updateNumericalValue({String? value = ''}) {
    numericalController = TextEditingController(text: value);
    setState(() {});
  }

  String getSanitizedNumericalValue(String value) {
    value = value.trim() == '' ? '0' : value;
    return !value.contains('.')
        ? '${int.parse(value)}'
        : '${double.parse(value)}';
  }

  void onValueChange(String value) {
    String sanitizedValue = getSanitizedNumericalValue(value);
    setState(() {});
    widget.onInputValueChange(sanitizedValue.trim());
  }

  @override
  void didUpdateWidget(covariant NumericalInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) {
      if (widget.inputField.isReadOnly!) {
        updateNumericalValue(value: widget.inputValue);
      }
      if (widget.inputValue == null || widget.inputValue == '') {
        updateNumericalValue();
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
                : numericalController,
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
