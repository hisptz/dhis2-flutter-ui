// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import 'material_card.dart';

///
/// `CustomButton` is a widget to have custom buttons
///
class CustomButton extends StatelessWidget {
  ///
  /// this is a default constructor for the `CustomButton`
  ///  it accepts parameters for the button label, highlight color and an on tap function
  ///
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.label,
    this.highlightedColor = Colors.white10,
  }) : super(key: key);

  /// this is a `VoidCallback` function that gets called whenever the button is tapped
  final VoidCallback onTap;

  /// this is a `String` label for the
  final String label;

  /// this is a `Color` for the highlight button color
  final Color highlightedColor;

  // TODO: add support for icon button
  // TODO: add configurable buttons
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      child: MaterialCard(
        borderRadius: 5.0,
        elevation: 2.0,
        body: InkWell(
          highlightColor: highlightedColor,
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10.0,
            ),
            alignment: Alignment.center,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 15.0,
            ),
            child: Text(
              label,
            ),
          ),
        ),
      ),
    );
  }
}
