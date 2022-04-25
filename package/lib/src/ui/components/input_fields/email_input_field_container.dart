import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/utils/entry_form_util.dart';
import 'package:flutter/material.dart';

class EmailInputFieldContainer extends StatefulWidget {
  const EmailInputFieldContainer({
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
  _EmailInputFieldContainerState createState() =>
      _EmailInputFieldContainerState();
}

class _EmailInputFieldContainerState extends State<EmailInputFieldContainer> {
  TextEditingController? emailController;

  @override
  void initState() {
    super.initState();
    setState(() {});
    updateNumericalValue(value: widget.inputValue);
  }

  updateNumericalValue({String? value = ''}) {
    emailController = TextEditingController(text: value);
    setState(() {});
  }

  String getSanitizedNumericalValue(String value) {
    value = value.trim() == '' ? '0' : value;
    return !value.contains('.')
        ? '${int.parse(value)}'
        : '${double.parse(value)}';
  }

  void onValueChange(String value) {
    bool isValidEmail = EntryFormUtil.isEmailValid(value..trim());
    widget.setValidationError(false);
    if (isValidEmail) {
      widget.setValidationError(false);
      widget.onInputValueChange(value.trim());
    } else {
      widget.setValidationError(true);
    }
  }

  @override
  void didUpdateWidget(covariant EmailInputFieldContainer oldWidget) {
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
                : emailController,
            keyboardType: TextInputType.emailAddress,
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
