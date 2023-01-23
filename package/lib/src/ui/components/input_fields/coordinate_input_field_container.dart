import 'package:dhis2_flutter_ui/src/ui/components/generic_components/circular_process_loader.dart';
import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/utils/entry_form_util.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CoordinateInputFieldContainer extends StatefulWidget {
  const CoordinateInputFieldContainer(
      {Key? key,
      required this.inputField,
      required this.onInputValueChange,
      this.inputValue})
      : super(key: key);

  final InputField inputField;
  final Function onInputValueChange;
  final String? inputValue;

  @override
  _CoordinateInputFieldContainerState createState() =>
      _CoordinateInputFieldContainerState();
}

class _CoordinateInputFieldContainerState
    extends State<CoordinateInputFieldContainer> {
  String? _longLatValue;
  bool isCoordinateSet = false;
  TextEditingController? coordinateController;

  @override
  void initState() {
    super.initState();
    setCurrentLocation(widget.inputValue);
  }

  setCurrentLocation(String? value) async {
    if (value == null) {
      Position currentPosition = await EntryFormUtil.getCurrentLocation();
      value =
          '${currentPosition.longitude.toString()},${currentPosition.latitude.toString()}';
    }
    setState(() {
      _longLatValue = value!.replaceAll('[', '').replaceAll(']', '');
      coordinateController = TextEditingController(text: _longLatValue);
      isCoordinateSet = true;
    });
    widget.onInputValueChange('[$value]');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: isCoordinateSet
              ? TextFormField(
                  controller: coordinateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.inputField.hint!,
                    errorText: null,
                  ),
                )
              : Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: CircularProcessLoader(
                    color: widget.inputField.inputColor,
                  ),
                ),
        ),
      ],
    );
  }
}
