import 'package:dhis2_flutter_ui/src/ui/models/dhis2_option.dart';

class DataElement {
  String? id;
  String? displayName;
  String? valueType;
  String? optionSet;
  List<Dhis2Option>? options;

  DataElement({
    required this.id,
    required this.valueType,
    required this.displayName,
    this.optionSet = '',
    this.options = const [],
  });

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['displayName'] = displayName;
    data['valueType'] = valueType;
    data['optionSet'] = optionSet;
    return data;
  }

  DataElement.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    displayName = mapData['displayName'];
    valueType = mapData['valueType'];
    optionSet = mapData['optionSet'];
  }

  factory DataElement.fromJson(
    dynamic json,
  ) {
    Map optionSetObj = json['optionSet'] ?? {};
    return DataElement(
      id: json['id'] ?? '',
      displayName: json['displayName'] ?? '',
      valueType: json['valueType'] ?? '',
      optionSet: optionSetObj['id'] ?? '',
    );
  }

  @override
  String toString() {
    return '<$id $valueType $options>';
  }
}
