import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/models/chart_data.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/http_service.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';

class CustomChartVisualization extends Visualization {
  CustomChartVisualization({required String id, required HttpService http})
      : super(id: id, type: "CHART", resource: "charts", http: http);

  @override
  CustomChartVisualization.fromJson(Map<String, dynamic> json,
      {required String id, required HttpService http})
      : super.fromJson(json,
            id: id, type: "CHART", resource: "charts", http: http);

  @override
  Future<CustomChartVisualization?> get() async {
    Map<String, dynamic>? json = await getJsonFromOnline();
    if (json != null) {
      return CustomChartVisualization.fromJson(json, id: id, http: http);
    }
    return null;
  }

  @override
  Future<void> getData() async {
    await super.getData();
    if (analyticsData != null) {
      switch (chartType) {
        case "COLUMN":
          visualizationData = ColumnVisualizationData(
              series: series!,
              category: category!,
              filtersConfig: filters,
              analyticsData: analyticsData);
          break;
        case "BAR":
          visualizationData = BarVisualizationData(
              series: series!,
              category: category!,
              filtersConfig: filters,
              analyticsData: analyticsData);
          break;
        case "LINE":
          visualizationData = LineVisualizationData(
              series: series!,
              category: category!,
              filtersConfig: filters,
              analyticsData: analyticsData);
          break;
        default:
          visualizationData = null;
      }
    } else {
      visualizationData = null;
    }
  }
}

class CascadeChartVisualization extends Visualization {
  CascadeChartVisualization({required String id, required HttpService http})
      : super(id: id, type: "CASCADE", resource: "charts", http: http);

  @override
  CascadeChartVisualization.fromJson(Map<String, dynamic> json,
      {required String id, required HttpService http})
      : super.fromJson(json,
            id: id, type: "CASCADE", resource: "charts", http: http);

  @override
  Future<CascadeChartVisualization?> get() async {
    Map<String, dynamic>? json = await getJsonFromOnline();
    if (json != null) {
      return CascadeChartVisualization.fromJson(json, id: id, http: http);
    }
    return null;
  }

  @override
  Future<void> getData() async {
    await super.getData();
    if (analyticsData != null) {
      switch (chartType) {
        case "COLUMN":
          visualizationData = ColumnVisualizationData(
              series: series!,
              category: category!,
              filtersConfig: filters,
              analyticsData: analyticsData);
          break;
        case "BAR":
          visualizationData = BarVisualizationData(
              series: series!,
              category: category!,
              filtersConfig: filters,
              analyticsData: analyticsData);
          break;
        case "LINE":
          visualizationData = LineVisualizationData(
              series: series!,
              category: category!,
              filtersConfig: filters,
              analyticsData: analyticsData);
          break;
        default:
          visualizationData = null;
      }
    } else {
      visualizationData = null;
    }
  }
}
