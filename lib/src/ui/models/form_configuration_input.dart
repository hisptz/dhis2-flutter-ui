class FormConfigurationInput {
  String? id;
  String? label;
  int? flex;
  bool? isBolded;
  String? hints;
  List<FormConfigurationInput>? subInputs;

  FormConfigurationInput({
    required this.id,
    required this.label,
    required this.flex,
    required this.isBolded,
    required this.hints,
    required this.subInputs,
  });

  factory FormConfigurationInput.fromJson(
    dynamic jsonData,
  ) {
    String flex = jsonData["flex"] == null ? '1' : '${jsonData["flex"]}';
    return FormConfigurationInput(
      id: jsonData['id'] ?? '',
      label: jsonData['label'] ?? '',
      flex: int.parse(flex),
      hints: jsonData['hints'] ?? '',
      isBolded: jsonData['isBolded'] ?? false,
      subInputs: jsonData['subInputs'] == null
          ? []
          : getSubInputs(jsonData['subInputs']),
    );
  }

  static List<FormConfigurationInput> getSubInputs(dynamic json) {
    List<FormConfigurationInput> subInputs = [];
    for (dynamic jsonData in json) {
      try {
        subInputs.add(FormConfigurationInput.fromJson(jsonData));
      } catch (e) {
        //
      }
    }
    return subInputs;
  }

  @override
  String toString() {
    return '<$id $label $subInputs>';
  }
}
