// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// `FormFieldInputIcon` is an input icon in the form field
class FormFieldInputIcon extends StatelessWidget {
  // this is the `String` representation of svg icon path
  final String? svgIcon;

  // this is a background `Color` for the icon
  final Color? backGroundColor;

  //
  // this is a default constructor for the `FormFieldInputIcon`
  // It accepts a `String` svg icon path and a background `Color`
  //
  const FormFieldInputIcon({
    Key? key,
    this.svgIcon,
    this.backGroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 5.0,
        top: 5.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(7.0),
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(9.0),
          child: SvgPicture.asset(svgIcon!),
        ),
      ),
    );
  }
}
