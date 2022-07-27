import 'package:dhis2_flutter_ui/src/ui/visualization/components/custom_table/models/table_data.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/http_service.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';

class TableVisualizationModel extends Visualization {
  TableVisualizationModel({required String id, required HttpService http})
      : super(
            id: id, type: "REPORT_TABLE", resource: "reportTables", http: http);

  @override
  Future<TableVisualizationModel?> get() async {
    Map<String, dynamic>? json = await getJsonFromOnline();
    if (json != null) {
      return TableVisualizationModel.fromJson(json, id: id, http: http);
    }
    return null;
  }

  TableVisualizationModel.fromJson(Map<String, dynamic> json,
      {required String id, required HttpService http})
      : super.fromJson(json,
            id: id, type: "REPORT_TABLE", resource: "reportTables", http: http);

  @override
  Future<void> getData() async {
    await super.getData();
    if (analyticsData != null) {
      visualizationData = TableVisualizationData(
          analyticsData: analyticsData,
          rowsConfig: rows,
          columnsConfig: columns,
          filtersConfig: filters);
    }
  }
}

class Dimension {
  final String id;
  final String name;
  final String dimension;

  Dimension({required this.dimension, required this.id, required this.name});
}
