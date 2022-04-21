class DataElementOption {
  String? id;
  String? name;
  String? code;
  String? optionSet;
  int? sortOrder;

  DataElementOption(
      {required this.id,
      required this.name,
      required this.code,
      required this.optionSet,
      required this.sortOrder});

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['optionSet'] = optionSet;
    data['sortOrder'] = sortOrder;
    return data;
  }

  DataElementOption.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    name = mapData['name'];
    code = mapData['code'];
    optionSet = mapData['optionSet'];
    sortOrder = int.parse(mapData['sortOrder']);
  }

  factory DataElementOption.fromJson(
    dynamic json,
  ) {
    return DataElementOption(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      code: json['code'] ?? '',
      optionSet: json['optionSet'] ?? '',
      sortOrder: json['sortOrder'] ?? 0,
    );
  }

  @override
  String toString() {
    return '<$id $name $code $sortOrder>';
  }
}
