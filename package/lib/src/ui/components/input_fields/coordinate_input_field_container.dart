// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../dhis2_flutter_ui.dart';
import '../../models/input_field.dart';
import '../../utils/entry_form_util.dart';

///
/// `CoordinateInputFieldContainer` isn the input field container for the coordinate field container
///
class CoordinateInputFieldContainer extends StatefulWidget {
  /// `InputField` is the input field metadata for the  coordinate input field
  final InputField inputField;

  /// `Function` callback called when input values had changed
  final Function onInputValueChange;

  /// `String` value for the coordinate input field
  final String? inputValue;

  ///
  ///  this is the default constructor for the `CoordinateInputFieldContainer`
  ///  the constructor accepts inputs as `InputField` metadata, `String` value and callback `Function` for when the coordinate value changes
  ///
  const CoordinateInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    this.inputValue,
  }) : super(key: key);
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

  ///  a setter function for setting the current location coordinates
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
