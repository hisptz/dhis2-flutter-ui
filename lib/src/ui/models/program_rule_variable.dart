class ProgramRuleVariable {
  String? id;
  String? name;
  String? programRuleVariableSourceType;
  String? program;
  String? dataElement;
  String? trackedEntityAttribute;
  String? programStageSection;
  String? programStage;

  ProgramRuleVariable({
    required this.id,
    required this.name,
    required this.program,
    this.programRuleVariableSourceType,
    this.dataElement = '',
    this.trackedEntityAttribute = '',
    this.programStageSection = '',
    this.programStage = '',
  });

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['program'] = program;
    data['dataElement'] = dataElement;
    data['trackedEntityAttribute'] = trackedEntityAttribute;
    data['programStageSection'] = programStageSection;
    data['programStage'] = programStage;
    return data;
  }

  ProgramRuleVariable.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    name = mapData['name'];
    program = mapData['program'];
    dataElement = mapData['dataElement'];
    trackedEntityAttribute = mapData['trackedEntityAttribute'];
    programStageSection = mapData['programStageSection'];
    programStage = mapData['programStage'];
  }

  factory ProgramRuleVariable.fromJson(
    dynamic json,
  ) {
    Map program = json['program'] ?? {};
    Map dataElement = json['dataElement'] ?? {};
    Map trackedEntityAttribute = json['trackedEntityAttribute'] ?? {};
    Map programStageSection = json['program'] ?? {};
    Map programStage = json['programStage'] ?? {};
    return ProgramRuleVariable(
      id: json['id'],
      name: json['name'],
      programRuleVariableSourceType:
          json['programRuleVariableSourceType'] ?? '',
      program: program['id'] ?? '',
      dataElement: dataElement['id'] ?? '',
      trackedEntityAttribute: trackedEntityAttribute['id'] ?? '',
      programStageSection: programStageSection['id'] ?? '',
      programStage: programStage['id'] ?? '',
    );
  }

  @override
  String toString() {
    return '<$id $name $program>';
  }
}
