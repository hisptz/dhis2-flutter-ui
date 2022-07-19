import 'package:dhis2_flutter_ui/src/ui/models/input_field_option.dart';
import 'package:flutter/material.dart';

class InputField {
  String id;
  String name;
  String? translatedName;
  String? description;
  String? translatedDescription;
  String valueType;
  Color? labelColor;
  Color? inputColor;
  Color? background;
  bool? renderAsRadio;
  bool? isReadOnly;
  bool? isPasswordField;
  bool? shouldCapitalize;
  bool? allowFuturePeriod;
  bool? showCountryLevelTree;
  bool? disablePastPeriod;
  bool? hasError;
  int? minAgeInYear;
  int? maxAgeInYear;
  int? numberOfMonth;
  bool? shouldUserCustomAgeLimit;
  String? suffixLabel;
  String? prefixLabel;
  String? hint;
  String? translatedHint;
  List<InputFieldOption>? options;
  bool? hasSubInputField;
  InputField? subInputField;
  List<int>? allowedSelectedLevels;
  List<String>? filteredPrograms;

  InputField({
    required this.id,
    required this.name,
    required this.valueType,
    this.hasSubInputField,
    this.description,
    this.inputColor,
    this.labelColor,
    this.background,
    this.renderAsRadio,
    this.isReadOnly,
    this.isPasswordField,
    this.shouldCapitalize,
    this.options,
    this.subInputField,
    this.allowedSelectedLevels,
    this.allowFuturePeriod,
    this.disablePastPeriod,
    this.translatedName,
    this.translatedDescription,
    this.hint,
    this.translatedHint,
    this.maxAgeInYear,
    this.minAgeInYear,
    this.numberOfMonth,
    this.prefixLabel,
    this.suffixLabel,
    this.filteredPrograms,
    this.hasError,
    this.shouldUserCustomAgeLimit,
    this.showCountryLevelTree,
  }) {
    isPasswordField = isPasswordField ?? false;
    shouldCapitalize = shouldCapitalize ?? false;
    showCountryLevelTree = showCountryLevelTree ?? false;
    allowedSelectedLevels = allowedSelectedLevels ?? [];
    allowFuturePeriod = allowFuturePeriod ?? false;
    disablePastPeriod = disablePastPeriod ?? false;
    isReadOnly = isReadOnly ?? false;
    description = description ?? '';
    hint = hint ?? '';
    hasSubInputField = hasSubInputField ?? false;
    renderAsRadio = renderAsRadio ?? false;
    options = options ?? [];
    filteredPrograms = filteredPrograms ?? [];
    inputColor = inputColor ?? Colors.black;
    labelColor = labelColor ?? const Color(0xFF1A3518);
    background = background ?? Colors.transparent;
    suffixLabel = suffixLabel ?? '';
  }

  @override
  String toString() {
    return '$id - $name - $isReadOnly';
  }
}
