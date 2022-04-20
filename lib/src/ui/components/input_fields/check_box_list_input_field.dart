import 'package:dhis2_flutter_ui/src/ui/components/input_fields/check_box_input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/models/input_field_option.dart';
import 'package:flutter/material.dart';

class CheckBoxListInputField extends StatefulWidget {
  const CheckBoxListInputField({
    Key? key,
    required this.inputField,
    required this.dataObject,
    this.isReadOnly = false,
    this.onInputValueChange,
  }) : super(key: key);

  final InputField inputField;
  final Map? dataObject;
  final Function? onInputValueChange;
  final bool isReadOnly;

  @override
  _CheckBoxListInputFieldState createState() => _CheckBoxListInputFieldState();
}

class _CheckBoxListInputFieldState extends State<CheckBoxListInputField> {
  final Map _inputValue = {};

  @override
  void initState() {
    super.initState();
    updateInputValueState();
  }

  updateInputValueState() {
    setState(() {
      for (InputFieldOption option in widget.inputField.options!) {
        _inputValue[option.code] = widget.dataObject![option.code] ?? false;
      }
    });
  }

  @override
  void didUpdateWidget(covariant CheckBoxListInputField oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.dataObject != widget.dataObject) updateInputValueState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.inputField.options!
          .map(
            (InputFieldOption option) => CheckBoxInputField(
              isReadOnly: widget.isReadOnly,
              label: option.name,
              value: widget.dataObject![option.code],
              color: widget.inputField.inputColor,
              onInputValueChange: (dynamic value) =>
                  widget.onInputValueChange!(option.code, '$value'),
            ),
          )
          .toList(),
    );
  }
}
