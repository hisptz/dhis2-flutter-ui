
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

class ChartVisualizationData extends VisualizationData {
  final String chartType;
  final String series;
  final String category;
  late dynamic chartSeries;

  get width {
    int categoriesNo = getChartCategoryIds()?.length ?? 1;
    int seriesNo = getChartSeriesIds()?.length ?? 1;
    return (categoriesNo * seriesNo) * ChartConstants.barWidth;
  }

  get domains => getChartCategoryIds();

  get measures => getChartSeriesIds();

  List<String>? getChartCategoryIds() {
    Map<String, List<dynamic>>? dimensions =
        metaData['dimensions']?.cast<String, List<dynamic>>();
    return dimensions?[category]?.cast<String>();
  }

  List<String>? getChartCategoryNames() {
    List<String>? chartCategoryIds = getChartCategoryIds();
    if (chartCategoryIds == null) {
      return null;
    }

    return chartCategoryIds.map((id) => getItemName(id)).toList();
  }

  List<String>? getChartSeriesIds() {
    Map metaData = analyticsData['metaData'].cast<String, dynamic>();
    Map<String, List<dynamic>> dimensions =
        metaData['dimensions'].cast<String, List<dynamic>>();
    return dimensions[series]?.cast<String>();
  }

  List<dynamic>? getChartData() {
    if (analyticsData != null) {
      List<ColumnSeries<ChartData, String>> chartSeries = [];

      int dataIndex =
          headers.indexWhere((element) => element['name'] == "value");

      List<String>? categoryIds = getChartCategoryIds();
      List<String>? seriesIds = getChartSeriesIds();

      for (String seriesId in seriesIds!) {
        String seriesName = metaData['items'][seriesId]["name"];
        List<ChartData>? values = categoryIds?.map((categoryId) {
          dynamic categoryName = metaData['items'][categoryId]['name'];
          List? row = rows.firstWhereOrNull(
              (row) => row.contains(seriesId) && row.contains(categoryId));
          double? value;
          if (row != null) {
            value = double.parse(row[dataIndex]);
          }
          return ChartData(domain: categoryName, value: value ?? 0.00);
        }).toList();

        ColumnSeries<ChartData, String> series = ColumnSeries(
            dataSource: values ?? [],
            spacing: 0.1,
            width: 0.8,
            name: seriesName,
            trackBorderColor: Colors.white,
            color: ChartConstants.colors[
                seriesIds.indexOf(seriesId) % ChartConstants.colors.length],
            dataLabelMapper: (ChartData data, _) =>
                VisualizationUtils.formatNumber(data.getMeasure()),
            dataLabelSettings: const DataLabelSettings(
                overflowMode: OverflowMode.trim,
                labelIntersectAction: LabelIntersectAction.shift,
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.outer,
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2), topRight: Radius.circular(2)),
            yAxisName: seriesName,
            legendItemText: seriesName,
            enableTooltip: true,
            xValueMapper: (ChartData data, _) => data.getDomain(),
            yValueMapper: (ChartData data, _) => data.getMeasure());

        chartSeries.add(series);
      }

      return chartSeries;
    }
    return null;
  }

  @override
  drawVisualization() {
    super.drawVisualization();
    chartSeries = getChartData() ?? [];
  }

  ChartVisualizationData(
      {required this.chartType,
      required filtersConfig,
      required this.series,
      required this.category,
      required analyticsData})
      : super(analyticsData: analyticsData, filtersConfig: filtersConfig);
}

class ColumnVisualizationData extends ChartVisualizationData {
  ColumnVisualizationData(
      {required String series,
      required String category,
      required analyticsData,
      required List filtersConfig})
      : super(
            chartType: 'COLUMN',
            series: series,
            category: category,
            analyticsData: analyticsData,
            filtersConfig: filtersConfig);
}

class BarVisualizationData extends ChartVisualizationData {
  BarVisualizationData(
      {required String series,
      required String category,
      required filtersConfig,
      required analyticsData})
      : super(
            chartType: 'COLUMN',
            series: series,
            category: category,
            analyticsData: analyticsData,
            filtersConfig: filtersConfig);

  @override
  List<dynamic>? getChartData() {
    if (analyticsData != null) {
      List<BarSeries<ChartData, String>> chartSeries = [];

      int dataIndex =
          headers.indexWhere((element) => element['name'] == "value");

      List<String>? categoryIds = getChartCategoryIds();
      List<String>? seriesIds = getChartSeriesIds();

      for (String seriesId in seriesIds!) {
        String seriesName = metaData['items'][seriesId]["name"];
        List<ChartData>? values = categoryIds?.map((categoryId) {
          dynamic categoryName = metaData['items'][categoryId]['name'];
          List? row = rows.firstWhereOrNull(
              (row) => row.contains(seriesId) && row.contains(categoryId));
          double? value;
          if (row != null) {
            value = double.parse(row[dataIndex]);
          }
          return ChartData(domain: categoryName, value: value ?? 0.00);
        }).toList();

        BarSeries<ChartData, String> series = BarSeries(
            name: seriesName,
            color: ChartConstants.colors[
                seriesIds.indexOf(seriesId) % ChartConstants.colors.length],
            dataSource: values ?? [],
            spacing: 0.1,
            width: 0.8,
            trackBorderColor: Colors.white,
            dataLabelMapper: (ChartData data, _) =>
                VisualizationUtils.formatNumber(data.getMeasure()),
            dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.outer,
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2), topRight: Radius.circular(2)),
            yAxisName: seriesName,
            legendItemText: seriesName,
            enableTooltip: true,
            xValueMapper: (ChartData data, _) => data.getDomain(),
            yValueMapper: (ChartData data, _) => data.getMeasure());

        chartSeries.add(series);
      }

      return chartSeries;
    }
    return null;
  }
}

class LineVisualizationData extends ChartVisualizationData {
  LineVisualizationData(
      {required String series,
      required String category,
      required filtersConfig,
      required analyticsData})
      : super(
            chartType: 'LINE',
            series: series,
            category: category,
            filtersConfig: filtersConfig,
            analyticsData: analyticsData);

  String getCategoryName(String categoryId) {
    return metaData['items'][categoryId]['name'] as String;
  }

  get domainNames {
    return domains?.map(getCategoryName).toList();
  }

  @override
  List<LineSeries<LineChartData, String>>? getChartData() {
    if (analyticsData != null) {
      List<LineSeries<LineChartData, String>> chartSeries = [];

      int dataIndex =
          headers.indexWhere((element) => element['name'] == "value");

      List<String>? categoryIds = getChartCategoryIds();
      List<String>? seriesIds = getChartSeriesIds();

      for (String seriesId in seriesIds!) {
        String seriesName = metaData['items'][seriesId]["name"];
        List<LineChartData>? values =
            categoryIds?.mapIndexed((index, categoryId) {
          String categoryName = metaData['items'][categoryId]['name'];
          List? row = rows.firstWhereOrNull(
              (row) => row.contains(seriesId) && row.contains(categoryId));
          double? value;
          if (row != null) {
            value = double.parse(row[dataIndex]);
          }
          return LineChartData(domain: categoryName, value: value ?? 0.00);
        }).toList();

        LineSeries<LineChartData, String> series =
            LineSeries<LineChartData, String>(
                markerSettings: const MarkerSettings(
                    isVisible: true,
                    width: 10,
                    height: 10,
                    shape: DataMarkerType.circle),
                pointColorMapper: (LineChartData data, _) => ChartConstants
                        .colors[
                    seriesIds.indexOf(seriesId) % ChartConstants.colors.length],
                name: seriesName,
                dataSource: values ?? [],
                color: ChartConstants.colors[
                    seriesIds.indexOf(seriesId) % ChartConstants.colors.length],
                dataLabelMapper: (ChartData data, _) =>
                    VisualizationUtils.formatNumber(data.getMeasure()),
                dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.outer,
                    textStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                yAxisName: seriesName,
                legendItemText: seriesName,
                enableTooltip: true,
                xValueMapper: (ChartData data, _) => data.getDomain(),
                yValueMapper: (ChartData data, _) => data.getMeasure());

        chartSeries.add(series);
      }

      return chartSeries;
    }
    return null;
  }
}

class ChartData {
  final dynamic domain;
  final double value;

  ChartData({required this.domain, required this.value});

  getDomain() {
    return domain;
  }

  getMeasure() {
    return value;
  }

  @override
  toString() {
    return 'ChartData{domain: $domain, value: $value}';
  }
}

class BarChart extends ChartData {
  BarChart({required String domain, required double value})
      : super(domain: domain, value: value);
}

class LineChartData extends ChartData {
  LineChartData({required String domain, required double value})
      : super(domain: domain, value: value);
}

class TableVisualizationData extends VisualizationData {
  final List<Map<String, dynamic>> columnsConfig;
  final List<Map<String, dynamic>> rowsConfig;
  late List tableColumns;
  late List tableRows;
  late List tableData;
  late int tableColumnsCount;

  TableVisualizationData(
      {required analyticsData,
      required this.rowsConfig,
      required this.columnsConfig,
      required filtersConfig})
      : super(analyticsData: analyticsData, filtersConfig: filtersConfig);

  get nameColumn {
    return "${getItemName(rowsConfig.first['id'])}/ ${getItemName(columnsConfig.first['id'])}";
  }

  List getTableRows() {
    List<String> rowDimensions =
        rowsConfig.map((rowConfig) => rowConfig['id'] as String).toList();
    List<List<dynamic>> dimensions = rowDimensions.map(getDimensions).toList();
    return dimensions
        .map((dimension) => dimension
            .map((row) => {'id': row, 'name': getItemName(row)})
            .toList())
        .toList()
        .first; //TODO: Only supports one row config for now
  }

  List<Map> getTableColumns() {
    List<String> columnDimensions = columnsConfig
        .map((columnConfig) => columnConfig['id'] as String)
        .toList();

    List<List<dynamic>> dimensions =
        columnDimensions.map(getDimensions).toList();
    return dimensions
        .map((dimension) => dimension
            .map((column) => {'id': column, 'name': getItemName(column)})
            .toList())
        .toList()
        .first; //TODO: Only supports one column config for now
  }

  int getTableColumnsCount() {
    return tableColumns.firstOrNull.length;
  }

  getData() {
    int dataIndex = headers.indexWhere((element) => element['name'] == "value");
    return tableRows.map((row) {
      return tableColumns.map((column) {
        if (column['id'] == "header") {
          return {
            "column": column['id'],
            "row": row["id"],
            "value": row["name"]
          };
        }

        List? dataRow = rows.firstWhereOrNull((element) =>
            element.contains(row['id']) && element.contains(column['id']));
        if (dataRow != null) {
          return {
            "column": column['id'],
            "row": row["id"],
            "value": dataRow[dataIndex]
          };
        }
        return {"column": column["id"], "row": row["id"], "value": ""};
      }).toList();
    }).toList();
  }

  getTableData() {
    tableRows = getTableRows();
    tableColumns = [
      {'id': "header", "name": nameColumn},
      ...getTableColumns()
    ];
    filters = getTableFilters();
    tableColumnsCount = getTableColumnsCount();
    tableData = getData();
  }

  get tableWidth => tableColumnsCount + 1;

  @override
  drawVisualization() {
    super.drawVisualization();
    getTableData();
  }
}
