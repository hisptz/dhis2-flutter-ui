import 'package:dhis2_flutter_ui/src/ui/components/input_fields/boolean_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/check_box_list_input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/date_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/email_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/numerical_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/percentage_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/phone_number_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/select_input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/text_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/components/input_fields/true_only_input_field_container.dart';
import 'package:dhis2_flutter_ui/src/ui/core/line_separator.dart';
import 'package:dhis2_flutter_ui/src/ui/models/input_field.dart';
import 'package:dhis2_flutter_ui/src/ui/models/input_field_option.dart';
import 'package:dhis2_flutter_ui/src/ui/utils/validator_util.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter/services.dart';

class InputFieldContainer extends StatefulWidget {
  const InputFieldContainer(
      {Key? key,
      required this.inputField,
      required this.hiddenInputFieldOptions,
      required this.hiddenFields,
      this.onInputValueChange,
      this.dataObject,
      this.mandatoryFieldObject,
      this.isEditableMode = true,
      this.showClearIcon = true,
      this.validators,
      this.inputFormaters,
      this.onError})
      : super(key: key);

  final InputField inputField;
  final bool? isEditableMode;
  final Function? onInputValueChange;
  final Map? dataObject;
  final Map? mandatoryFieldObject;
  final Map hiddenInputFieldOptions;
  final bool showClearIcon;
  final Map? hiddenFields;

  /// Validate input based on pre-defined valiadtors[FormValidator] or your own custom functions
  ///
  /// If you are using your own function ,
  ///
  /// It should return string containing error message when there is error otherwise null
  ///
  /// ```
  ///    InputFieldContainer(
  ///                  inputField:
  ///                      InputField(id: 'id', name: 'name', valueType: 'TEXT'),
  ///                  validators: [
  ///                    Validators.pattern("T—[\\d+\$]{4}—[\\d+\$]{4}",
  ///                        "Enter Valid ID number. "),
  ///                  ],
  ///                ))
  ///  ```
  final List<FormValidator>? validators;

  /// Format input based on pre-defined pattern[InputMask] or your own custom fommater
  ///
  /// ```
  ///    InputFieldContainer(
  ///                  inputField:
  ///                      InputField(id: 'id', name: 'name', valueType: 'TEXT'),
  ///                  inputFormaters: [
  ///                    InputMask(pattern: "X—XXXX—XXXX", separator: "—"),
  ///                 ],
  ///                ))
  ///  ```
  final List<TextInputFormatter>? inputFormaters;
  final Function(String?)? onError;

  @override
  State<InputFieldContainer> createState() => _InputFieldContainerState();
}

class _InputFieldContainerState extends State<InputFieldContainer> {
  String? error;

  bool get hasError => (error != null || widget.inputField.hasError as bool);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: widget.inputField.background),
      padding: widget.inputField.background != Colors.transparent
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
              visible: widget.inputField.name != '',
              child: Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: widget.inputField.name,
                        style: TextStyle(
                          color: widget.inputField.hasError != null &&
                                  widget.inputField.hasError!
                              ? Colors.red
                              : widget.inputField.labelColor,
                          fontSize: 13.0,
                          fontWeight: FontWeight.normal,
                        ),
                        children: [
                          TextSpan(
                            text: widget.mandatoryFieldObject != null &&
                                    widget.mandatoryFieldObject![
                                            widget.inputField.id] ==
                                        true
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
              visible: widget.inputField.description != '',
              child: Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.inputField.description!,
                        style: const TextStyle().copyWith(
                          color: widget.inputField.labelColor,
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
              visible: widget.inputField.hasSubInputField! &&
                  widget.inputField.subInputField != null &&
                  (widget.hiddenFields == null ||
                      '${widget.hiddenFields![widget.inputField.id]}'.trim() !=
                          'true'),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      child: widget.isEditableMode == true
                          ? _getInputField(widget.inputField.subInputField,
                              widget.isEditableMode)
                          : _getInputFieldLabel(widget.inputField),
                    ),
                  ),
                  Visibility(
                    visible: widget.inputField.subInputField != null,
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.inputField.subInputField != null
                                ? widget.inputField.subInputField!.name
                                : '',
                          ),
                          Container(
                            child: widget.isEditableMode == true
                                ? _getInputField(
                                    widget.inputField.subInputField,
                                    widget.isEditableMode)
                                : _getInputFieldLabel(
                                    widget.inputField.subInputField),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: !widget.inputField.hasSubInputField!,
              child: Container(
                child: widget.isEditableMode == true
                    ? _getInputField(widget.inputField, widget.isEditableMode)
                    : _getInputFieldLabel(widget.inputField),
              ),
            ),
            LineSeparator(
                color:
                    error == null ? widget.inputField.inputColor! : Colors.red),
            Container(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                error ?? "",
                style: const TextStyle(color: Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }

  setValidationError(bool hasValidationError) {
    //TODO set validations error messages
  }

  Widget _getInputFieldLabel(InputField? inputField) {
    dynamic value =
        inputField != null && '${widget.dataObject![inputField.id]}' != 'null'
            ? '${widget.dataObject![inputField.id]}'
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
              dataObject: widget.dataObject,
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

  Widget _getInputField(InputField? inputField, bool? isEditableMode) {
    return Container(
      child: inputField != null
          ? Row(
              children: [
                Expanded(
                  child: inputField.valueType == 'CHECK_BOX'
                      ? CheckBoxListInputField(
                          inputField: inputField,
                          onInputValueChange: (id, value) {
                            widget.onInputValueChange!(id, value);
                          },
                          dataObject: widget.dataObject,
                        )
                      : inputField.options!.isNotEmpty
                          ? SelectInputField(
                              hiddenInputFieldOptions: widget
                                      .hiddenInputFieldOptions[inputField.id] ??
                                  const {},
                              color: inputField.inputColor,
                              isReadOnly: inputField.isReadOnly,
                              renderAsRadio: inputField.renderAsRadio,
                              onInputValueChange: (dynamic value) => widget
                                  .onInputValueChange!(inputField.id, value),
                              options: inputField.options,
                              selectedOption: widget.dataObject![inputField.id],
                            )
                          : inputField.valueType == 'TEXT' ||
                                  inputField.valueType == 'LONG_TEXT'
                              ? TextInputFieldContainer(
                                  inputField: inputField,
                                  inputValue: widget.dataObject![inputField.id],
                                  inputFormatters: widget.inputFormaters,
                                  onInputValueChange: (String value) {
                                    widget.onInputValueChange!(
                                        inputField.id, value);
                                    error = value.validate(widget.validators);
                                    if (widget.onError != null) {
                                      setState(() {
                                        widget.onError!(error);
                                      });
                                    }
                                  })
                              : inputField.valueType ==
                                          'INTEGER_ZERO_OR_POSITIVE' ||
                                      inputField.valueType == 'NUMBER'
                                  ? NumericalInputFieldContainer(
                                      inputField: inputField,
                                      inputValue:
                                          widget.dataObject![inputField.id],
                                      onInputValueChange: (dynamic value) {
                                        widget.onInputValueChange!(
                                            inputField.id, value);
                                      })
                                  : inputField.valueType == 'EMAIL'
                                      ? EmailInputFieldContainer(
                                          inputField: inputField,
                                          inputValue:
                                              widget.dataObject![inputField.id],
                                          setValidationError:
                                              setValidationError,
                                          onInputValueChange: (dynamic value) =>
                                              widget.onInputValueChange!(
                                                  inputField.id, value),
                                        )
                                      : inputField.valueType == 'PERCENTAGE'
                                          ? PercentageInputFieldContainer(
                                              inputField: inputField,
                                              inputValue: widget
                                                  .dataObject![inputField.id],
                                              setValidationError:
                                                  setValidationError,
                                              onInputValueChange:
                                                  (dynamic value) => widget
                                                          .onInputValueChange!(
                                                      inputField.id, value),
                                            )
                                          : inputField.valueType ==
                                                  'PHONE_NUMBER'
                                              ? PhoneNumberInputFieldContainer(
                                                  inputField: inputField,
                                                  inputValue:
                                                      widget.dataObject![
                                                          inputField.id],
                                                  onInputValueChange: (dynamic
                                                          value) =>
                                                      widget.onInputValueChange!(
                                                          inputField.id, value),
                                                )
                                              : inputField.valueType ==
                                                      'BOOLEAN'
                                                  ? BooleanInputFieldContainer(
                                                      inputField: inputField,
                                                      inputValue:
                                                          widget.dataObject![
                                                              inputField.id],
                                                      onInputValueChange: (dynamic
                                                              value) =>
                                                          widget.onInputValueChange!(
                                                              inputField.id,
                                                              value),
                                                    )
                                                  : inputField.valueType ==
                                                          'TRUE_ONLY'
                                                      ? TrueOnlyInputFieldContainer(
                                                          inputField:
                                                              inputField,
                                                          inputValue: widget
                                                                  .dataObject![
                                                              inputField.id],
                                                          onInputValueChange:
                                                              (dynamic value) {
                                                            widget.onInputValueChange!(
                                                                inputField.id,
                                                                '$value');
                                                          },
                                                        )
                                                      : inputField.valueType ==
                                                              'DATE'
                                                          ? DateInputFieldContainer(
                                                              inputField:
                                                                  inputField,
                                                              inputValue: widget
                                                                      .dataObject![
                                                                  inputField
                                                                      .id],
                                                              onInputValueChange: (dynamic
                                                                      value) =>
                                                                  widget.onInputValueChange!(
                                                                      inputField
                                                                          .id,
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
