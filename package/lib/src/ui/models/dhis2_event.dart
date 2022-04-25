import 'package:dhis2_flutter_ui/src/ui/models/dhis2_event_data_value.dart';

class Dhis2Event {
  String? id;
  String? event;
  String? eventDate;
  String? orgUnit;
  String? program;
  String? programStage;
  String? storedBy;
  String? completedDate;
  String? status; // ACTIVE or COMPLETED
  String? syncStatus; // synced || not-synced
  List<Dhis2EventDataValue>? dataValues;

  Dhis2Event({
    required this.event,
    required this.eventDate,
    required this.orgUnit,
    required this.program,
    required this.programStage,
    required this.status,
    this.storedBy = '',
    this.completedDate = '',
    this.syncStatus = 'synced',
    this.dataValues = const [],
  }) {
    id = event;
  }

  bool get isSynced => syncStatus == "synced";

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['event'] = event;
    data['eventDate'] = eventDate;
    data['orgUnit'] = orgUnit;
    data['program'] = program;
    data['programStage'] = programStage;
    data['status'] = status;
    data['storedBy'] = storedBy;
    data['completedDate'] = completedDate;
    data['syncStatus'] = syncStatus;
    return data;
  }

  Dhis2Event.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    event = mapData['event'];
    eventDate = (mapData['eventDate'] ?? '').split('T')[0];
    orgUnit = mapData['orgUnit'] ?? '';
    program = mapData['program'] ?? '';
    programStage = mapData['programStage'] ?? '';
    status = mapData['status'] ?? '';
    storedBy = mapData['storedBy'] ?? '';
    completedDate = (mapData['completedDate'] ?? '').split('T')[0];
    syncStatus = mapData['syncStatus'] ?? '';
    dataValues = mapData['dataValues'] ?? [];
  }

  factory Dhis2Event.fromJson(
    dynamic json,
  ) {
    String event = json['event'] ?? '';
    return Dhis2Event(
      event: event,
      eventDate: json['eventDate'] ?? '',
      orgUnit: json['orgUnit'] ?? '',
      program: json['program'] ?? '',
      programStage: json['programStage'] ?? '',
      status: json['status'] ?? '',
      storedBy: json['storedBy'] ?? '',
      completedDate: json['completedDate'] ?? '',
      syncStatus: json['syncStatus'] ?? 'synced',
      dataValues: getDataValues(json, event),
    );
  }

  static List<Dhis2EventDataValue> getDataValues(dynamic json, String eventId) {
    List<Dhis2EventDataValue> dhis2DataValues = [];
    try {
      for (dynamic dataValueJson in json['dataValues']) {
        dhis2DataValues.add(Dhis2EventDataValue.fromJson(
          dataValueJson,
          eventId,
        ));
      }
    } catch (e) {
      //
    }
    return dhis2DataValues;
  }

  @override
  String toString() {
    return '$event $eventDate';
  }
}
