import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:flutter/cupertino.dart';

class TrueOnlyInputFieldContainer extends StatefulWidget {
  const TrueOnlyInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    this.inputValue,
    this.hideInputLabel = false,
  }) : super(key: key);

  final InputField inputField;
  final bool hideInputLabel;
  final Function onInputValueChange;
  final dynamic inputValue;

  @override
  _TrueOnlyInputFieldContainerState createState() =>
      _TrueOnlyInputFieldContainerState();
}

class _TrueOnlyInputFieldContainerState
    extends State<TrueOnlyInputFieldContainer> {
  late bool _value;
  String? _switchLabel;
  Color inActiveColor = const Color(0xFF737373);
  String yesLabel = 'Yes';
  String noLabel = 'Yes';

  @override
  void initState() {
    super.initState();
    updateInputValueState();
  }

  updateInputValueState() {
    bool value = false;
    value = '${widget.inputValue}' == 'true' ? true : false;
    onSetValue(value);
  }

  @override
  void didUpdateWidget(covariant TrueOnlyInputFieldContainer oldWidget) {
    super.didUpdateWidget(widget);
    if (oldWidget.inputValue != widget.inputValue) updateInputValueState();
  }

  onSetValue(bool value) {
    setState(() {
      _value = value;
      _switchLabel = value ? yesLabel : noLabel;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Visibility(
          visible: !widget.hideInputLabel,
          child: Container(
            width: 30.0,
            margin: const EdgeInsets.only(
              left: 5.0,
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(
              horizontal: 1.0,
            ),
            child: Text(
              '$_switchLabel',
              style: const TextStyle().copyWith(
                fontSize: 12.0,
                color: _value ? widget.inputField.inputColor : inActiveColor,
              ),
            ),
          ),
        ),
        CupertinoSwitch(
          activeColor: widget.inputField.inputColor,
          trackColor: inActiveColor,
          value: _value,
          onChanged: widget.inputField.isReadOnly!
              ? null
              : (bool value) {
                  onSetValue(value);
                  widget.onInputValueChange(
                    value ? value : '',
                  );
                },
        ),
      ],
    );
  }
}
