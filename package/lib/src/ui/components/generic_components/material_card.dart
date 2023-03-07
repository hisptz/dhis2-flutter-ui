// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

///
/// `MaterialCard` is a widget for rendering cards. It offers flexibility for elevation and border radius.
///

class MaterialCard extends StatelessWidget {
  ///
  /// this is the default constructor for the `MaterialCard`
  /// it accepts the body widget, card elevation and border radius
  ///
  const MaterialCard({
    Key? key,
    required this.body,
    this.elevation = 1.0,
    this.borderRadius = 12.0,
  }) : super(key: key);

  /// this is a `Widget` that is the body for the `MaterialCard`
  final Widget body;

  /// this is a `double` that represents the elevation of the `MaterialCard`
  final double elevation;

  /// this is a `double` for the border radius of the `MaterialCard`
  final double borderRadius;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Material(
      type: MaterialType.card,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            borderRadius,
          ),
        ),
      ),
      child: body,
    );
  }
}
