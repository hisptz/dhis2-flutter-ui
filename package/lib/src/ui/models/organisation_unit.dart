class OrganisationUnit {
  String? id;
  String? name;
  String? parent;
  String? code;
  String? path;
  int? level;
  List<String>? dataSets;
  List<String>? programs;
  List<String>? children;

  OrganisationUnit({
    required this.id,
    required this.name,
    this.parent = '',
    this.code = '',
    this.path = '',
    this.level = 0,
    this.dataSets = const [],
    this.programs = const [],
    this.children = const [],
  });

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parent'] = parent;
    data['code'] = code;
    data['level'] = level;
    data['path'] = path;
    return data;
  }

  OrganisationUnit.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    name = mapData['name'];
    parent = mapData['parent'];
    code = mapData['code'];
    level = int.parse(mapData['level']);
    parent = mapData['parent'];
  }

  factory OrganisationUnit.fromJson(
    dynamic json,
  ) {
    Map parentObj = json['parent'] ?? {};
    List programList = json['programs'] as List<dynamic>;
    List dataSetList = json['dataSets'] as List<dynamic>;
    List childrenList = json['children'] as List<dynamic>;
    return OrganisationUnit(
      id: json['id'],
      name: json['name'] ?? '',
      parent: parentObj['id'] ?? '',
      code: json['code'],
      level: json['level'],
      programs: programList.map((program) => '${program["id"]}').toList(),
      dataSets: dataSetList.map((dataSet) => '${dataSet["id"]}').toList(),
      children: childrenList.map((child) => '${child["id"]}').toList(),
    );
  }

  @override
  String toString() {
    return '<$id : $name $level>';
  }
}
