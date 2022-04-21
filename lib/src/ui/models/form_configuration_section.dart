
import 'package:dhis2_flutter_ui/src/ui/models/form_configuration_input.dart';

class FormConfigurationSection {
  String? title;
  String? instruction;
  List<List<FormConfigurationInput>>? inputRows;
  List<FormConfigurationSection>? subSections;

  FormConfigurationSection({
    required this.title,
    this.instruction,
    this.inputRows,
    this.subSections,
  }) {
    instruction = instruction ?? '';
    inputRows = inputRows ?? [];
    subSections = subSections ?? [];
  }

  factory FormConfigurationSection.fromJson(
    dynamic json,
  ) {
    return FormConfigurationSection(
      title: json['title'] ?? '',
      instruction: json['instruction'] ?? '',
      inputRows:
          json['inputRows'] == null ? [] : getFormConfigurationInputRows(json),
      subSections: json['subSections'] == null
          ? []
          : getFormConfigurationSubSection(json),
    );
  }

  static List<List<FormConfigurationInput>> getFormConfigurationInputRows(
    dynamic json,
  ) {
    List<List<FormConfigurationInput>> inputRows = [];
    try {
      for (dynamic inputRowJson in json['inputRows']) {
        List<FormConfigurationInput> inputRow = [];
        for (dynamic jsonData in inputRowJson) {
          try {
            inputRow.add(FormConfigurationInput.fromJson(jsonData));
          } catch (e) {
            //
          }
        }
        inputRows.add(inputRow);
      }
    } catch (e) {
      //
    }
    return inputRows;
  }

  static List<FormConfigurationSection> getFormConfigurationSubSection(
    dynamic json,
  ) {
    List sections = json['subSections'] as List;
    return sections
        .map((section) => FormConfigurationSection.fromJson(section))
        .toList();
  }

  @override
  String toString() {
    return '<$title $inputRows $subSections>';
  }
}
