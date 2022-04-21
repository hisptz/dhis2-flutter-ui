class Dhis2EventDataValue {
  String? id;
  String? event;
  String? dataElement;
  String? value;

  Dhis2EventDataValue({
    required this.event,
    required this.dataElement,
    this.value = '',
  }) {
    id = '${event}_$dataElement';
  }

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['event'] = event;
    data['dataElement'] = dataElement;
    data['value'] = value;
    return data;
  }

  Dhis2EventDataValue.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    event = mapData['event'];
    dataElement = mapData['dataElement'];
    value = mapData['value'];
  }

  factory Dhis2EventDataValue.fromJson(
    dynamic json,
    String eventId,
  ) {
    return Dhis2EventDataValue(
      event: eventId,
      dataElement: json['dataElement'] ?? '',
      value: json['value'] ?? '',
    );
  }

  @override
  String toString() {
    return '<$id $value>';
  }
}
