import 'package:dhis2_flutter_ui/src/ui/components/input_fields/radio_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/models/input_field_option.dart';
import 'package:flutter/material.dart';

class BooleanInputFieldContainer extends StatefulWidget {
  const BooleanInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    this.inputValue,
  }) : super(key: key);

  final InputField inputField;
  final Function onInputValueChange;
  final dynamic inputValue;

  @override
  _BooleanInputFieldContainerState createState() =>
      _BooleanInputFieldContainerState();
}

class _BooleanInputFieldContainerState
    extends State<BooleanInputFieldContainer> {
  final List<InputFieldOption> options = [
    InputFieldOption(
      name: 'Yes',
      translatedName: 'Yes',
      code: true,
    ),
    InputFieldOption(
      name: 'No',
      translatedName: 'No',
      code: false,
    ),
  ];
  bool? _inputValue;

  @override
  void initState() {
    super.initState();
    updateInputFieldState();
  }

  updateInputFieldState() {
    setState(() {
      _inputValue =
          widget.inputValue != null && '${widget.inputValue}' == 'true'
              ? true
              : widget.inputValue != null && '${widget.inputValue}' == 'false'
                  ? false
                  : null;
    });
  }

  @override
  void didUpdateWidget(covariant BooleanInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) updateInputFieldState();
  }

  @override
  Widget build(BuildContext context) {
    return RadioInputFieldContainer(
      options: options,
      isReadOnly: widget.inputField.isReadOnly,
      activeColor: widget.inputField.inputColor,
      currentValue: _inputValue,
      onInputValueChange: widget.onInputValueChange,
    );
  }
}
