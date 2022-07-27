import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/components/legend_item.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/models/chart_data.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/models/chart_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/constants/chart.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/utils/chart_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomLineChart extends StatelessWidget {
  final Chart? visualization;
  final bool fullScreen;

  CustomLineChart(this.visualization, {Key? key, required this.fullScreen})
      : super(key: key);

  final numberFormatter = NumberFormat.compact(locale: 'en_US');

  String formatValue(List domainNames, num? index) {
    if (index == null) {
      return '';
    }
    return '${domainNames[index.toInt()]}';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height =
        MediaQuery.of(context).size.height * (fullScreen ? 0.9 : 0.6);
    if (visualization?.visualizationData == null) {
      return const Center(child: Text("Could not retrieve chart data"));
    }
    List<LineSeries<LineChartData, String>> chartSeries =
        visualization?.visualizationData?.chartSeries ?? [];

    String title = visualization?.visualizationData?.title ?? '';

    int viewportCount = ChartUtils.getViewedBarCount(context, visualization);

    return chartSeries != null
        ? SfCartesianChart(
            title: ChartTitle(
                text: title,
                alignment: ChartAlignment.center,
                textStyle: const TextStyle(fontSize: 12)),
            palette: ChartConstants.colors,
            zoomPanBehavior: ZoomPanBehavior(
              enablePanning: true,
              zoomMode: ZoomMode.x,
            ),
            crosshairBehavior: CrosshairBehavior(enable: true),
            enableAxisAnimation: true,
            enableSideBySideSeriesPlacement: true,
            tooltipBehavior: TooltipBehavior(
              enable: true,
            ),
            primaryYAxis: NumericAxis(
                isVisible: true,
                labelIntersectAction: AxisLabelIntersectAction.wrap,
                numberFormat: NumberFormat.compact(locale: 'en_US')),
            legend: Legend(
                legendItemBuilder:
                    (String name, dynamic series, dynamic point, int index) {
                  return CustomLegendItem(
                    chartSeries: chartSeries,
                    index: index,
                    series: series,
                  );
                },
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap,
                isVisible: true,
                isResponsive: false),
            primaryXAxis: CategoryAxis(
              interval: 1,
              labelsExtent: (width - 40),
              maximumLabelWidth: (width - 40),
              edgeLabelPlacement: EdgeLabelPlacement.shift,
              labelAlignment: LabelAlignment.center,
              labelRotation: viewportCount > 7 ? 90 : 0,
              majorGridLines: const MajorGridLines(width: 0),
              visibleMaximum: (viewportCount - 1),
              labelPlacement: LabelPlacement.betweenTicks,
              labelIntersectAction: AxisLabelIntersectAction.wrap,
            ),
            series: chartSeries,
          )
        : const Center(
            child: Text("No data available"),
          );
  }
}
