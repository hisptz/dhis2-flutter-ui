import 'package:collection/collection.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_data.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/constants/chart.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

class CascadeVisualizationData extends ChartVisualizationData {
  CascadeVisualizationData(
      {required String series,
      required String category,
      required analyticsData,
      required List filtersConfig})
      : super(
            chartType: 'CASCADE',
            series: "pe",
            category: "dx",
            analyticsData: analyticsData,
            filtersConfig: filtersConfig);

  generateTargets(List<String> seriesIds) {
    const initialTarget = 1600000;
    const targetFactor = 0.9;

    List<double> targets = [initialTarget.toDouble()];

    for (int i = 0; i < seriesIds.length; i++) {
      targets.add(targets.last * targetFactor);
    }

    return targets;
  }

  @override
  List<dynamic>? getChartData() {
    if (analyticsData != null) {
      List<ColumnSeries<CascadeData, String>> chartSeries = [];

      int dataIndex =
          headers.indexWhere((element) => element['name'] == "value");

      List<String>? categoryIds = getChartCategoryIds();
      List<String>? seriesIds = getChartSeriesIds();

      List<double> targets = generateTargets(categoryIds ?? []);

      for (String seriesId in seriesIds!) {
        String seriesName = metaData['items'][seriesId]["name"];
        List<CascadeData>? values = [
          CascadeData(
              domain: "Estimated PLHIV",
              value: 1600000,
              target: 1600000,
              color: ChartConstants.colors.first)
        ];

        values.addAll((categoryIds ?? []).mapIndexed((index, categoryId) {
          dynamic categoryName = metaData['items'][categoryId]['name'];
          List? row = rows.firstWhereOrNull(
              (row) => row.contains(seriesId) && row.contains(categoryId));
          double? value;
          if (row != null) {
            value = double.parse(row[dataIndex]);
          }
          return CascadeData(
              domain: categoryName,
              value: value ?? 0.00,
              target: targets[index + 1],
              color: ChartConstants
                  .colors[(index + 1) % ChartConstants.colors.length]);
        }));

        ColumnSeries<CascadeData, String> series = ColumnSeries(
            dataSource: values,
            spacing: 0.1,
            width: 0.8,
            name: seriesName,
            trackBorderColor: Colors.white,
            color: ChartConstants.colors[
                seriesIds.indexOf(seriesId) % ChartConstants.colors.length],
            dataLabelMapper: (CascadeData data, _) =>
                "${VisualizationUtils.formatNumber(data.getTarget())} \n ${data.percentage}%",
            dataLabelSettings: const DataLabelSettings(
                overflowMode: OverflowMode.trim,
                labelIntersectAction: LabelIntersectAction.shift,
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2), topRight: Radius.circular(2)),
            yAxisName: seriesName,
            legendItemText: seriesName,
            enableTooltip: true,
            pointColorMapper: (CascadeData data, _) => data.getColor(),
            xValueMapper: (CascadeData data, _) => data.getDomain(),
            yValueMapper: (CascadeData data, _) => data.getMeasure());
        ColumnSeries<CascadeData, String> targetSeries = ColumnSeries(
            dataSource: values,
            spacing: 0.1,
            width: 0.8,
            dashArray: [5, 5],
            borderColor: ChartConstants.colors[
                seriesIds.indexOf(seriesId) % ChartConstants.colors.length],
            name: seriesName,
            borderWidth: 1,
            opacity: 0,
            color: Colors.transparent,
            dataLabelMapper: (CascadeData data, _) =>
                VisualizationUtils.formatNumber(data.getTarget()),
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
            isVisibleInLegend: false,
            xValueMapper: (CascadeData data, _) => data.getDomain(),
            yValueMapper: (CascadeData data, _) => data.getTarget());

        chartSeries.addAll([series, targetSeries]);
      }

      return chartSeries;
    }
    return null;
  }
}

class CascadeData extends ChartData {
  final double target;

  final Color color;

  CascadeData(
      {required String domain,
      required double value,
      required this.target,
      required this.color})
      : super(domain: domain, value: value);

  getTarget() {
    return target;
  }

  getColor() {
    return color;
  }

  get percentage {
    return ((getMeasure() / target) * 100).toStringAsFixed(2);
  }
}
