class ProgramIndicator {
  String? id;
  String? aggregationType;
  String? expression;
  String? filter;
  String? program;

  ProgramIndicator({
    required this.id,
    required this.aggregationType,
    required this.expression,
    required this.program,
    this.filter = '',
  });

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['aggregationType'] = aggregationType;
    data['expression'] = expression;
    data['program'] = program;
    data['filter'] = filter;
    return data;
  }

  ProgramIndicator.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    aggregationType = mapData['aggregationType'];
    expression = mapData['expression'];
    program = mapData['program'];
    filter = mapData['filter'];
  }

  factory ProgramIndicator.fromJson(
    dynamic json,
  ) {
    Map programObj = json['program'] ?? {};
    return ProgramIndicator(
      id: json['id'],
      expression: json['expression'],
      aggregationType: json['aggregationType'],
      program: programObj['id'] ?? '',
      filter: json['filter'] ?? '',
    );
  }

  @override
  String toString() {
    return '<$id : $program>';
  }
}
