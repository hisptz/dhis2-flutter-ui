import 'package:flutter/material.dart';

class CheckBoxInputFieldContainer extends StatefulWidget {
  final Function onInputValueChange;
  final String? label;
  final Color? color;
  final dynamic value;
  final bool isReadOnly;

  const CheckBoxInputFieldContainer({
    Key? key,
    required this.onInputValueChange,
    required this.label,
    required this.value,
    required this.color,
    required this.isReadOnly,
  }) : super(key: key);

  @override
  State<CheckBoxInputFieldContainer> createState() =>
      _CheckBoxInputFieldContainerState();
}

class _CheckBoxInputFieldContainerState
    extends State<CheckBoxInputFieldContainer> {
  bool? _inputValue;

  @override
  void initState() {
    super.initState();
    updateInputValueState();
  }

  updateInputValueState() {
    setState(() {
      _inputValue = widget.value != null && '${widget.value}' == 'true';
    });
  }

  @override
  void didUpdateWidget(covariant CheckBoxInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.value != widget.value) updateInputValueState();
  }

  void onInputValueChange(bool? value) {
    updateInputValueState();
    widget.onInputValueChange(value == true ? value : null);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _inputValue,
          activeColor: _inputValue! ? widget.color : null,
          checkColor: _inputValue! ? Colors.white : null,
          onChanged: widget.isReadOnly ? null : onInputValueChange,
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(),
            child: Text(
              widget.label!,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: _inputValue! ? widget.color : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
