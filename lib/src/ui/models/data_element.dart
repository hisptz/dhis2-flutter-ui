
import 'package:dhis2_flutter_ui/src/ui/models/data_element_option.dart';

class DataElement {
  String? id;
  String? valueType;
  String? optionSet;
  List<DataElementOption>? options;

  DataElement({
    required this.id,
    required this.valueType,
    this.optionSet = '',
    this.options = const [],
  });

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['valueType'] = valueType;
    data['optionSet'] = optionSet;
    return data;
  }

  DataElement.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    valueType = mapData['valueType'];
    optionSet = mapData['optionSet'];
  }

  factory DataElement.fromJson(
    dynamic json,
  ) {
    Map optionSetObj = json['optionSet'] ?? {};
    return DataElement(
      id: json['id'] ?? '',
      valueType: json['valueType'] ?? '',
      optionSet: optionSetObj['id'] ?? '',
    );
  }

  @override
  String toString() {
    return '<$id $valueType $options>';
  }
}
