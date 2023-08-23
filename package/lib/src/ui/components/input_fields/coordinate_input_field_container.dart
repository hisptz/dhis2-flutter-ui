// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import '../../models/input_field.dart';
import 'package:geolocator/geolocator.dart';
import 'map.dart';

class CoordinateInputFieldContainer extends StatefulWidget {
  /// `InputField` metadata for the numerical input field container
  final InputField inputField;

  /// `Function` callback called when input values had changed
  final Function onInputValueChange;

  /// `String` value for the numerical field
  final String? inputValue;

  final bool? disableUpdateLocation;

  ///
  /// this is a default constructor for `CoordinateInputFieldContainer`
  ///
  const CoordinateInputFieldContainer({
    Key? key,
    required this.inputField,
    required this.onInputValueChange,
    this.inputValue,
    this.disableUpdateLocation = true,
  }) : super(key: key);

  @override
  State<CoordinateInputFieldContainer> createState() =>
      _CoordinateInputFieldContainerState();
}

class _CoordinateInputFieldContainerState
    extends State<CoordinateInputFieldContainer> {
  // Text controller for the location input field
  // final TextEditingController _locationController = TextEditingController();
 
 TextEditingController? locationController;

  @override
  void initState() {
    super.initState();
    locationController = TextEditingController(text: widget.inputValue);
  }

// Function to get the current location
  Future<void> _getLocation() async {
    bool locationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationEnabled) {
      // Handle if location services are disabled
      debugPrint("Location services are disabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("User denied permissions to access the device's location.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Handle the scenario where user has permanently denied location access
      debugPrint(
          "User denied permissions forever to access the device's location.");
      return;
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      String newLocation = "${position.latitude}, ${position.longitude}";

      setState(() {
        if (widget.inputField.disableUpdateLocation==false) {
          locationController?.text = newLocation;
        }
      });

    // Call the onValueChange function with the new coordinates
    onValueChange(newLocation);

    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }

  // Function to open the map screen for selecting a location
  void _openMapForLocation() async {
    final position = await Navigator.push<Position>(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(locationText: locationController!.text),
      ),
    );
    if (position != null) {
      String newLocation = "${position.latitude}, ${position.longitude}";

    setState(() {
      locationController?.text = newLocation;
    });
       // Call the onValueChange function with the new coordinates
    onValueChange(newLocation);
    }
  }

  void onValueChange(String value){
    widget.onInputValueChange(value.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: locationController,
            readOnly: widget.inputField.isReadOnly!,
            onChanged: onValueChange,
            decoration: InputDecoration(
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.inputField.disableUpdateLocation==false)
                    IconButton(
                      icon: const Icon(Icons.my_location),
                      onPressed: _getLocation,
                    ),
                  IconButton(
                    icon: const Icon(Icons.map),
                    onPressed: _openMapForLocation,
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
