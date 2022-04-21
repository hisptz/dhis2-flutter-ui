
import 'package:dhis2_flutter_ui/src/ui/models/form_configuration_section.dart';

class FormConfiguration {
  String? programStage;
  List<FormConfigurationSection>? sections;

  FormConfiguration({
    this.programStage,
    required this.sections,
  }) {
    programStage = programStage ?? '';
  }

  factory FormConfiguration.fromJson(
    dynamic jsonData,
  ) {
    return FormConfiguration(
      programStage: jsonData['programStage'] ?? '',
      sections: getFormConfigurationSection(jsonData),
    );
  }

  static List<FormConfigurationSection> getFormConfigurationSection(
    dynamic jsonData,
  ) {
    List<FormConfigurationSection> formConfigurationSections = [];
    List sections = jsonData['sections'] as List;
    for (dynamic section in sections) {
      formConfigurationSections.add(FormConfigurationSection.fromJson(section));
    }
    return formConfigurationSections;
  }

  @override
  String toString() {
    return '<$programStage $sections>';
  }
}
