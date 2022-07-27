
import 'package:collection/collection.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/constants/chart.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class VisualizationData {
  final Map<String, dynamic> analyticsData;
  late dynamic visualizationData;
  late List<dynamic> headers;
  late Map metaData;
  late List<dynamic> rows;
  final List<Map<String, dynamic>> filtersConfig;
  late List<dynamic> filters;

  get title => filters.join(' - ');

  List<dynamic> getRows() {
    return analyticsData['rows'] as List<dynamic>;
  }

  Map getMetaData() {
    return analyticsData['metaData'] as Map;
  }

  String getItemName(dynamic itemId) {
    return metaData['items'][itemId]['name'] as String;
  }

  List<dynamic> getDimensions(String dimensionId) {
    return metaData['dimensions'][dimensionId] as List<dynamic>;
  }

  getTableFilters() {
    List<String> filterDimensions = filtersConfig
        .map((filterConfig) => filterConfig['id'] as String)
        .toList();
    List<List<dynamic>> dimensions =
        filterDimensions.map(getDimensions).toList();
    return dimensions
        .map((dimension) => dimension.map(getItemName).toList())
        .toList()
        .expand((element) => element)
        .toList();
  }

  List<dynamic> getHeaders() {
    return analyticsData['headers'] as List<dynamic>;
  }

  VisualizationData(
      {required this.analyticsData, required this.filtersConfig}) {
    drawVisualization();
  }

  drawVisualization() {
    rows = getRows();
    headers = getHeaders();
    metaData = getMetaData();
    filters = getTableFilters();
  }
}
