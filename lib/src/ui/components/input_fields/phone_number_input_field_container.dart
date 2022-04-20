import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:flutter/material.dart';

class PhoneNumberInputFieldContainer extends StatefulWidget {
  const PhoneNumberInputFieldContainer(
      {Key? key,
      required this.inputField,
      required this.onInputValueChange,
      this.inputValue})
      : super(key: key);

  final InputField inputField;
  final Function onInputValueChange;
  final String? inputValue;

  @override
  _PhoneNumberInputFieldContainerState createState() =>
      _PhoneNumberInputFieldContainerState();
}

class _PhoneNumberInputFieldContainerState
    extends State<PhoneNumberInputFieldContainer> {
  TextEditingController? phoneNumberController;

  @override
  void initState() {
    super.initState();
    phoneNumberController = TextEditingController(text: widget.inputValue);
  }

  void onValueChange(String value) {
    widget.onInputValueChange(value.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            readOnly: widget.inputField.isReadOnly!,
            controller: phoneNumberController,
            keyboardType: TextInputType.phone,
            onChanged: onValueChange,
            style: const TextStyle().copyWith(
              color: widget.inputField.inputColor,
            ),
            textInputAction: TextInputAction.next,
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
