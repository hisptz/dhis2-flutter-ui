// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.
import 'package:flutter/material.dart';

/// `InputClearIcon` is a an input clear icon for the  input fields
class InputClearIcon extends StatelessWidget {
  /// a `bool` variable for wether or not to show clear icon
  final bool showClearIcon;

  /// a `Function` callback for when the clear icon is clicked
  final Function onClearInput;

  ///
  /// this is a default constructor for the `InputClearIcon`
  /// the constructor accepts `bool` value to decide wether on not to show icon and a callback `Function` for when the icon is clicked
  ///
  const InputClearIcon({
    Key? key,
    required this.showClearIcon,
    required this.onClearInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return !showClearIcon
        ? Container()
        : Container(
            height: 20.0,
            margin: const EdgeInsets.only(
              left: 8.0,
              bottom: 5.0,
            ),
            child: IconButton(
              padding: const EdgeInsets.only(bottom: 10),
              icon: Icon(
                Icons.delete,
                color: Colors.red.withOpacity(0.8),
              ),
              onPressed: onClearInput as void Function()?,
            ),
          );
  }
}
