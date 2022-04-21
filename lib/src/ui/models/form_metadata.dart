class FormMetadata {
  String? id;
  String? name;
  String? formType;
  String? programType;
  String? periodType;
  int? openFuturePeriods;

  FormMetadata({
    required this.id,
    required this.name,
    required this.formType,
    this.programType = '',
    this.periodType = '',
    this.openFuturePeriods = 0,
  });

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['formType'] = formType;
    data['programType'] = programType;
    data['periodType'] = periodType;
    data['openFuturePeriods'] = openFuturePeriods;
    return data;
  }

  FormMetadata.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    name = mapData['name'];
    formType = mapData['formType'];
    programType = mapData['programType'];
    periodType = mapData['periodType'];
    openFuturePeriods = int.parse(mapData['openFuturePeriods']);
  }

  factory FormMetadata.fromJson(
    dynamic json,
    String formType,
  ) {
    return FormMetadata(
      id: json['id'],
      name: json['name'],
      formType: formType,
      programType: json['programType'] ?? '',
      periodType: json['periodType'] ?? '',
      openFuturePeriods: json['openFuturePeriods'] ?? 0,
    );
  }

  @override
  String toString() {
    return '<$id $name $formType>';
  }
}
