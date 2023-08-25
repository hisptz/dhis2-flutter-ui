// Copyright (c) 2023, HISP Tanzania Developers.
// All rights reserved. Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../core/app_constants.dart';
import 'input_field_option.dart';

///
/// `InputField` is the class for the input fields
///
class InputField {
  /// this is the `String` representation of the id for the field's input
  String id;

  /// this is the `String` representation of the display name for the field data input
  String name;

  /// this is optional `String` translated display name for the input field
  String? translatedName;

  /// this is a `String` description for the input field
  String? description;

  /// this is a `String` translated description for the input field
  String? translatedDescription;

  /// this is a `String` value type as per DHIS2 standards
  String valueType;

  /// this is a `Color` for the input labels
  Color? labelColor;

  /// this is a `Color` for the input borders
  Color? inputColor;

  /// this is a background `Color` for the input field
  Color? background;

  /// this is a `bool` that specifies wether `InputField` should render its option as radio or not
  bool? renderAsRadio;

  /// this is a `bool` that specifies wether `InputField` is read only or not
  bool? isReadOnly;

  /// this is a `bool` that specifies wether `InputField` should be rendered as password input
  bool? isPasswordField;

  /// this is a `bool` that specifies wether `InputField` value should be capitalized or not
  bool? shouldCapitalize;

  /// this is a `bool` that specifies wether `InputField` should allow future dates if its of type `DATE`
  bool? allowFuturePeriod;

  /// this is a `bool` that specifies wether `InputField` should allow past dates if its of type `DATE`
  bool? disablePastPeriod;

  /// this is a `bool` that specifies wether `InputField` should show an error
  bool? hasError;

  /// this is an `int` that specifies years that is minimum years that can be captured by the `InputField`
  int? minYear;

  /// this is an `int` that specifies years that is maximum years that can be captured by the `InputField`
  int? maxYear;

  /// this is an `int` that specifies the minimum number of months that can be captured by the `InputField`
  int? numberOfMonth;

  /// this is a `String` label that is displayed as a suffix to the `InputField`
  String? suffixLabel;

  /// this is a `String` label that is displayed as a prefix to the `InputField`
  String? prefixLabel;

  /// this is a `String` representation of a hint to the `InputField`
  String? hint;

  /// this is a `String` representation of a translated hint to the `InputField`
  String? translatedHint;

  /// this is a `List` of `InputFieldOption` for the `InputField`
  List<InputFieldOption>? options;

  /// this is a `bool` that indicates wether an input has a sub-input field
  bool? hasSubInputField;

  /// this is an `InputField` that represents a sub-input field
  InputField? subInputField;

  /// this is a `DateTime` that represents a minimum date allowed to be captured by a `DATE` field
  DateTime? minDate;

  /// this is a `DateTime` that represents a maximum date allowed to be captured by a `DATE` field
  DateTime? maxDate;

  /// this is selected levels field
  List<int> allowedSelectedLevels;

  /// State variable for auto updating location
  bool? disableUpdateLocation;

  ///
  /// This is the default constructor to the `InputField`
  ///
  InputField(
      {required this.id,
      required this.name,
      required this.valueType,
      this.translatedName = '',
      this.description = '',
      this.hint = '',
      this.translatedHint = '',
      this.translatedDescription = '',
      this.prefixLabel = '',
      this.suffixLabel = '',
      this.subInputField,
      this.maxYear,
      this.minYear,
      this.numberOfMonth,
      this.minDate,
      this.maxDate,
      this.inputColor = AppConstants.defaultColor,
      this.labelColor = const Color(0xFF1A3518),
      this.background = Colors.transparent,
      this.options = const [],
      this.renderAsRadio = false,
      this.isReadOnly = false,
      this.hasSubInputField = false,
      this.isPasswordField = false,
      this.shouldCapitalize = false,
      this.hasError = false,
      this.allowFuturePeriod = false,
      this.disablePastPeriod = false,
      this.allowedSelectedLevels = const [],
      this.disableUpdateLocation = false,
      });

  /// `InputField.toString()` is the method to return the `String` representation of the `InputField`
  @override
  String toString() {
    return '$id - $name - $isReadOnly';
  }
}
