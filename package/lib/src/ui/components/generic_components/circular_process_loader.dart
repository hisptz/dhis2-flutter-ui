// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

///
/// `CircularProcessLoader` is a widget for loading indications
///
class CircularProcessLoader extends StatelessWidget {
  ///
  /// This is a default constructor for the `CircularProcessLoader`
  /// It accepts the loader color and size
  ///
  const CircularProcessLoader({
    Key? key,
    this.color,
    this.size,
  }) : super(key: key);

  /// this is a `Color` for the loading indicator icon
  final Color? color;

  /// this is a `double` size for the loading indicator
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                strokeWidth: size ?? 4,
                valueColor: AlwaysStoppedAnimation(
                  color ?? Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
