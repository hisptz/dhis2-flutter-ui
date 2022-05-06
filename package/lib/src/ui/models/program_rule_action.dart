class ProgramRuleAction {
  String? id;
  String? programRule;
  String? data;
  String? content;
  String? programRuleActionType;
  String? location;
  String? dataElement;
  String? trackedEntityAttribute;
  String? programStageSection;
  String? programStage;

  ProgramRuleAction({
    required this.id,
    required this.programRule,
    this.data = '',
    this.content = '',
    this.programRuleActionType = '',
    this.location = '',
    this.dataElement = '',
    this.trackedEntityAttribute = '',
    this.programStageSection = '',
    this.programStage = '',
  });

  Map<String, dynamic> toMap() {
    var mapData = <String, dynamic>{};
    mapData['id'] = id;
    mapData['programRule'] = programRule;
    mapData['data'] = data;
    mapData['content'] = content;
    mapData['programRuleActionType'] = programRuleActionType;
    mapData['location'] = location;
    mapData['dataElement'] = dataElement;
    mapData['trackedEntityAttribute'] = trackedEntityAttribute;
    mapData['programStageSection'] = programStageSection;
    mapData['programStage'] = programStage;
    return mapData;
  }

  ProgramRuleAction.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    programRule = mapData['programRule'];
    data = mapData['data'];
    content = mapData['content'];
    programRuleActionType = mapData['programRuleActionType'];
    location = mapData['location'];
    dataElement = mapData['dataElement'];
    trackedEntityAttribute = mapData['trackedEntityAttribute'];
    programStageSection = mapData['programStageSection'];
    programStage = mapData['programStage'];
  }

  factory ProgramRuleAction.fromJson(
    dynamic json,
  ) {
    Map programRule = json['programRule'] ?? {};
    Map dataElement = json['dataElement'] ?? {};
    Map trackedEntityAttribute = json['trackedEntityAttribute'] ?? {};
    Map programStageSection = json['program'] ?? {};
    Map programStage = json['programStage'] ?? {};
    return ProgramRuleAction(
      id: json['id'],
      programRule: programRule['id'] ?? '',
      data: json['data'] ?? '',
      content: json['content'] ?? '',
      programRuleActionType: json['programRuleActionType'] ?? '',
      location: json['location'] ?? '',
      dataElement: dataElement['id'] ?? '',
      trackedEntityAttribute: trackedEntityAttribute['id'] ?? '',
      programStageSection: programStageSection['id'] ?? '',
      programStage: programStage['id'] ?? '',
    );
  }

  @override
  String toString() {
    return '<$id $programRuleActionType $programRule>';
  }
}
