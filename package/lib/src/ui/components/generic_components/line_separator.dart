// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

//
// `LineSeparator` is the widget for the a line
//
class LineSeparator extends StatelessWidget {
  //
  // this is the default constructor for the `LineSeparator`
  // it accepts the color and height for the line
  //
  const LineSeparator({
    Key? key,
    required this.color,
    this.height = 2.0,
  }) : super(key: key);

  // this is a `Color` for the line
  final Color color;

  // this is a `double` for the height of the line, it can be considered as a thickness of line
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: height,
            color: color,
          ),
        ),
      ),
    );
  }
}
