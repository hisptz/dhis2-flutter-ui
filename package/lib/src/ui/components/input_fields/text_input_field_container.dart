import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextInputFieldContainer extends StatefulWidget {
  const TextInputFieldContainer({
    Key? key,
    required this.inputField,
    this.onInputValueChange,
    this.inputValue,
    this.showInputCheckedIcon = true,
  }) : super(key: key);

  final InputField inputField;
  final Function? onInputValueChange;
  final String? inputValue;
  final bool showInputCheckedIcon;

  @override
  _TextInputFieldContainerState createState() =>
      _TextInputFieldContainerState();
}

class _TextInputFieldContainerState extends State<TextInputFieldContainer> {
  TextEditingController? textController;
  String? _value;
  String? _lastInputValue = '';
  bool? _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _value = widget.inputValue;
    _isPasswordVisible = !widget.inputField.isPasswordField!;
    setState(() {});
    updateTextValue(value: widget.inputValue);
  }

  updateTextValue({String? value = ''}) {
    _value = value;
    setState(() {});
    textController = TextEditingController(text: value);
  }

  onValueChange(String value) {
    if (_lastInputValue != value) {
      setState(() {
        _value = value;
        _lastInputValue = _value;
      });
      widget.onInputValueChange!(value.trim());
    }
  }

  _updatePasswordVisibilityStatus() {
    _isPasswordVisible = !_isPasswordVisible!;
    setState(() {});
  }

  clearSearchValue() {
    updateTextValue();
    widget.onInputValueChange!(_value);
  }

  @override
  void didUpdateWidget(covariant TextInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) {
      if (widget.inputField.isReadOnly!) {
        updateTextValue(value: widget.inputValue);
      }
      if (widget.inputValue == null || widget.inputValue == '') {
        updateTextValue();
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
                : textController,
            onChanged: onValueChange,
            maxLines: widget.inputField.valueType == 'LONG_TEXT' ? null : 1,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            obscureText: !_isPasswordVisible!,
            textCapitalization: widget.inputField.shouldCapitalize!
                ? TextCapitalization.sentences
                : TextCapitalization.none,
            style: const TextStyle().copyWith(
              color: widget.inputField.inputColor,
            ),
            decoration: InputDecoration(
              hintText: widget.inputField.hint ?? '',
              border: InputBorder.none,
              errorText: null,
              suffixIconConstraints: const BoxConstraints(
                maxHeight: 20.0,
                minHeight: 20.0,
              ),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    child: Text(widget.inputField.suffixLabel ?? '',
                        style: const TextStyle().copyWith(
                          color: widget.inputField.inputColor,
                        )),
                    visible: widget.inputField.suffixLabel != '' &&
                        _value != null &&
                        '$_value'.trim() != '',
                  ),
                  Container(
                    child: !widget.inputField.isPasswordField!
                        ? null
                        : Container(
                            margin: EdgeInsets.only(
                              right: _value != null && '$_value'.trim() != ''
                                  ? 0.0
                                  : 5.0,
                            ),
                            child: GestureDetector(
                              onTap: _updatePasswordVisibilityStatus,
                              child: Container(
                                color: widget.inputField.inputColor!
                                    .withOpacity(0.01),
                                child: SvgPicture.asset(
                                    _isPasswordVisible!
                                        ? 'assets/icons/login-close-eye.svg'
                                        : 'assets/icons/login-open-eye.svg',
                                    color: widget.inputField.inputColor,
                                    package: 'dhis2_flutter_ui'),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
