import 'package:dhis2_flutter_ui/src/ui/models/input_field_option.dart';
import 'package:flutter/material.dart';

class RadioInputFieldContainer extends StatefulWidget {
  const RadioInputFieldContainer({
    Key? key,
    required this.options,
    required this.currentValue,
    required this.onInputValueChange,
    required this.isReadOnly,
    this.activeColor,
  }) : super(key: key);

  final List<InputFieldOption>? options;
  final dynamic currentValue;
  final Function onInputValueChange;
  final Color? activeColor;
  final bool? isReadOnly;

  @override
  _RadioInputFieldContainerState createState() =>
      _RadioInputFieldContainerState();
}

class _RadioInputFieldContainerState extends State<RadioInputFieldContainer> {
  dynamic _currentValue;

  @override
  void initState() {
    super.initState();
    updateInputFieldState();
  }

  updateInputFieldState() {
    setState(() {
      _currentValue = widget.currentValue;
    });
  }

  @override
  void didUpdateWidget(covariant RadioInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.currentValue != widget.currentValue) updateInputFieldState();
  }

  void setSelectedOption(dynamic value) {
    updateInputFieldState();
    widget.onInputValueChange(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Wrap(
        children: widget.options!
            .map(
              (InputFieldOption option) => Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Radio(
                    activeColor: widget.activeColor,
                    value: option.code,
                    groupValue: _currentValue,
                    onChanged: widget.isReadOnly! ? null : setSelectedOption,
                  ),
                  Text(
                    option.name,
                    style: const TextStyle().copyWith(
                      color: _currentValue == option.code
                          ? widget.activeColor
                          : null,
                    ),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
