import 'dart:convert';

import 'package:dhis2_flutter_ui/src/ui/models/form_configuration.dart';


class FormConfigMetadata {
  String? id;
  String? config;

  FormConfigMetadata({
    required this.id,
    this.config,
  });

  Map<String, dynamic> toMap() {
    var data = <String, dynamic>{};
    data['id'] = id;
    data['config'] = config;

    return data;
  }

  String get programStage => toEntryFormConfiguration().programStage ?? '';

  FormConfiguration toEntryFormConfiguration() {
    dynamic jsonData = json.decode(config!);
    try {
      jsonData = json.decode(jsonData);
    } catch (e) {
      //
    }
    return FormConfiguration.fromJson(jsonData);
  }

  FormConfigMetadata.fromMap(Map<String, dynamic> mapData) {
    id = mapData['id'];
    config = mapData['config'];
  }

  factory FormConfigMetadata.fromJson(
    dynamic jsonData,
  ) {
    return FormConfigMetadata(
      id: jsonData['id'] ?? '',
      config: json.encode(jsonData['config']),
    );
  }

  @override
  String toString() {
    return '<$id>';
  }
}
