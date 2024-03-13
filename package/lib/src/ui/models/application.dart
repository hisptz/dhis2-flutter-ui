// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

//
// `Application` is a model class for the application
//
class Application {
  // This is the `String` representation of the application id.
  String id;

  // This is the `String` label for the application
  String label;

  // This is the `String` iconPath for the application
  String iconPath;

  // This is the `List` of user groups for the current logged in user
  List<String> userGroups;

  // This is a `Widget` page for the application
  Widget page;

  // This is the default constructor of the `Application` class
  Application(
      {required this.id,
      required this.label,
      required this.iconPath,
      required this.page,
      this.userGroups = const []});

  // `Application.toString()` is the function to return the `String` representation of `Application`
  @override
  String toString() => label;
}
