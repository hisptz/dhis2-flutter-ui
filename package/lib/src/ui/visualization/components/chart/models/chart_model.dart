import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/models/chart_data.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_data.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';

class CustomChartVisualization extends Visualization {
  CustomChartVisualization({required String id})
      : super(id: id, type: "CHART", resource: "charts");

  @override
  CustomChartVisualization.fromJson(Map<String, dynamic> json, {required String id})
      : super.fromJson(json, id: id, type: "CHART", resource: "charts");

  @override
  Future<CustomChartVisualization?> get() async {
    Map<String, dynamic>? json = await getJsonFromOnline();
    if (json != null) {
      return CustomChartVisualization.fromJson(json, id: id);
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
  CascadeChartVisualization({required String id})
      : super(id: id, type: "CASCADE", resource: "charts");

  @override
  CascadeChartVisualization.fromJson(Map<String, dynamic> json, {required String id})
      : super.fromJson(json, id: id, type: "CASCADE", resource: "charts");

  @override
  Future<CascadeChartVisualization?> get() async {
    Map<String, dynamic>? json = await getJsonFromOnline();
    if (json != null) {
      return CascadeChartVisualization.fromJson(json, id: id);
    }
    return null;
  }

  @override
  Future<void> getData() async {
    await super.getData();
    if (analyticsData != null) {
      visualizationData = CascadeVisualizationData(
          series: series!,
          category: category!,
          filtersConfig: filters,
          analyticsData: analyticsData);
    } else {
      visualizationData = null;
    }
  }
}
