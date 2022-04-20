import 'package:dhis2_flutter_ui/src/ui/components/input_fields/boolean_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/check_box_list_input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/date_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/numerical_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/phone_number_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/select_input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/text_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/true_only_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/core/app_contants.dart';
import 'package:dhis2_flutter_ui/src/ui/core/line_separator.dart';
import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/models/input_field_option.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class InputFieldContainer extends StatelessWidget {
  const InputFieldContainer({
    Key? key,
    required this.inputField,
    required this.hiddenInputFieldOptions,
    required this.hiddenFields,
    this.onInputValueChange,
    this.dataObject,
    this.mandatoryFieldObject,
    this.isEditableMode = true,
    this.showClearIcon = true,
  }) : super(key: key);

  final InputField inputField;
  final bool? isEditableMode;
  final Function? onInputValueChange;
  final Map? dataObject;
  final Map? mandatoryFieldObject;
  final Map hiddenInputFieldOptions;
  final bool showClearIcon;
  final Map? hiddenFields;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: inputField.background),
      padding: inputField.background != Colors.transparent
          ? const EdgeInsets.only(
              top: 10.0,
              bottom: 0.0,
              left: 10.0,
              right: 10.0,
            )
          : const EdgeInsets.all(0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 2.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: inputField.name != '',
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: inputField.name,
                        style: TextStyle(
                          color: inputField.hasError != null &&
                                  inputField.hasError!
                              ? Colors.red
                              : inputField.labelColor,
                          fontSize: 13.0,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            text: mandatoryFieldObject != null &&
                                    mandatoryFieldObject![inputField.id] == true
                                ? ' *'
                                : '',
                            style: const TextStyle(
                              color: Colors.redAccent,
                              fontSize: 12.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Visibility(
              visible: inputField.description != '',
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        inputField.description!,
                        style: const TextStyle().copyWith(
                          color: inputField.labelColor,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Visibility(
              visible: inputField.hasSubInputField! &&
                  inputField.subInputField != null &&
                  (hiddenFields == null ||
                      '${hiddenFields![inputField.id]}'.trim() != 'true'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: isEditableMode == true
                          ? _getInputField(
                              inputField.subInputField,
                              isEditableMode,
                            )
                          : _getInputFieldLabel(inputField),
                    ),
                  ),
                  Visibility(
                    visible: inputField.subInputField != null,
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            inputField.subInputField != null
                                ? inputField.subInputField!.name
                                : '',
                          ),
                          Container(
                            child: isEditableMode == true
                                ? _getInputField(
                                    inputField.subInputField,
                                    isEditableMode,
                                  )
                                : _getInputFieldLabel(inputField.subInputField),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !inputField.hasSubInputField!,
              child: Container(
                child: isEditableMode == true
                    ? _getInputField(
                        inputField,
                        isEditableMode,
                      )
                    : _getInputFieldLabel(inputField),
              ),
            ),
            LineSeparator(color: AppConstants.appInputBorderColor)
          ],
        ),
      ),
    );
  }

  Widget _getInputFieldLabel(InputField? inputField) {
    dynamic value =
        inputField != null && '${dataObject![inputField.id]}' != 'null'
            ? '${dataObject![inputField.id]}'
            : '   ';
    if (inputField != null) {
      if (inputField.valueType == "BOOLEAN") {
        value = value == 'true'
            ? 'Yes'
            : value == 'false'
                ? 'No'
                : value;
      } else if (inputField.valueType == 'TRUE_ONLY') {
        value = value == 'true' ? 'Yes' : value;
      } else if (inputField.options!.isNotEmpty) {
        InputFieldOption? option = inputField.options!.firstWhereOrNull(
            (InputFieldOption option) =>
                option.code != null && option.code == value);
        value = option != null ? option.name : value;
      }
    }
    return Container(
      child: inputField != null && inputField.valueType == 'CHECK_BOX'
          ? CheckBoxListInputField(
              inputField: inputField,
              isReadOnly: true,
              dataObject: dataObject,
            )
          : Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal: 10.0,
                  ),
                  child: Text(
                    value.toString(),
                    style: const TextStyle().copyWith(
                      color: inputField != null && inputField.inputColor != null
                          ? inputField.inputColor
                          : null,
                      fontWeight: FontWeight.w500,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _getInputField(
    InputField? inputField,
    bool? isEditableMode,
  ) {
    return Container(
      child: inputField != null
          ? Row(
              children: [
                Expanded(
                  child: inputField.valueType == 'CHECK_BOX'
                      ? CheckBoxListInputField(
                          inputField: inputField,
                          onInputValueChange: (id, value) {
                            onInputValueChange!(id, value);
                          },
                          dataObject: dataObject,
                        )
                      : inputField.options!.isNotEmpty
                          ? SelectInputField(
                              hiddenInputFieldOptions:
                                  hiddenInputFieldOptions[inputField.id] ??
                                      const {},
                              color: inputField.inputColor,
                              isReadOnly: inputField.isReadOnly,
                              renderAsRadio: inputField.renderAsRadio,
                              onInputValueChange: (dynamic value) =>
                                  onInputValueChange!(inputField.id, value),
                              options: inputField.options,
                              selectedOption: dataObject![inputField.id],
                            )
                          : inputField.valueType == 'TEXT' ||
                                  inputField.valueType == 'LONG_TEXT'
                              ? TextInputFieldContainer(
                                  inputField: inputField,
                                  inputValue: dataObject![inputField.id],
                                  onInputValueChange: (dynamic value) =>
                                      onInputValueChange!(inputField.id, value),
                                )
                              : inputField.valueType ==
                                          'INTEGER_ZERO_OR_POSITIVE' ||
                                      inputField.valueType == 'NUMBER'
                                  ? NumericalInputFieldContainer(
                                      inputField: inputField,
                                      inputValue: dataObject![inputField.id],
                                      onInputValueChange: (dynamic value) =>
                                          onInputValueChange!(
                                              inputField.id, value),
                                    )
                                  : inputField.valueType == 'PHONE_NUMBER'
                                      ? PhoneNumberInputFieldContainer(
                                          inputField: inputField,
                                          inputValue:
                                              dataObject![inputField.id],
                                          onInputValueChange: (dynamic value) =>
                                              onInputValueChange!(
                                                  inputField.id, value),
                                        )
                                      : inputField.valueType == 'BOOLEAN'
                                          ? BooleanInputFieldContainer(
                                              inputField: inputField,
                                              inputValue:
                                                  dataObject![inputField.id],
                                              onInputValueChange:
                                                  (dynamic value) =>
                                                      onInputValueChange!(
                                                          inputField.id, value),
                                            )
                                          : inputField.valueType == 'TRUE_ONLY'
                                              ? TrueOnlyInputFieldContainer(
                                                  inputField: inputField,
                                                  inputValue: dataObject![
                                                      inputField.id],
                                                  onInputValueChange:
                                                      (dynamic value) {
                                                    onInputValueChange!(
                                                        inputField.id,
                                                        '$value');
                                                  },
                                                )
                                              : inputField.valueType == 'DATE'
                                                  ? DateInputFieldContainer(
                                                      inputField: inputField,
                                                      inputValue: dataObject![
                                                          inputField.id],
                                                      onInputValueChange:
                                                          (dynamic value) =>
                                                              onInputValueChange!(
                                                                  inputField.id,
                                                                  value),
                                                    )
                                                  : Text(
                                                      '${inputField.valueType} is not supported',
                                                    ),
                ),
              ],
            )
          : const Text(''),
    );
  }
}