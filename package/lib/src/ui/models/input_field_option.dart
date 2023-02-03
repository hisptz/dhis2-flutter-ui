// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

///
/// `InputFieldOption` This is the input field option class
///
class InputFieldOption {
  /// this is the `String` for the option name
  String name;

  /// this is the `String` for the option translated name
  String? translatedName;

  /// this is the `dynamic` value for the option code
  dynamic code;

  /// `InputFieldOption` this is the default
  InputFieldOption({
    required this.code,
    required this.name,
    this.translatedName,
  });

  /// `InputFieldOption.toString()` is the method to return the `String` representation of the `InputFieldOption`
  @override
  String toString() => '$name $code';
}
