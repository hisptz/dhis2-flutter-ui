import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/components/legend_item.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/models/chart_data.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/models/chart_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/constants/chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomBarChart extends StatelessWidget {
  final Chart? chart;
  final bool? horizontal;
  final bool fullScreen;

  CustomBarChart(
    this.chart, {
    Key? key,
    this.horizontal,
    required this.fullScreen,
  }) : super(key: key);

  final numberFormatter = NumberFormat.compact(locale: 'en_US');

  double getChartWidth(BuildContext context, Visualization? chart) {
    double minWidth = MediaQuery.of(context).size.width * 0.90;

    if (chart == null) {
      return minWidth;
    }
    double width = double.parse('${chart.visualizationData?.width}');
    if (width < minWidth) {
      return minWidth;
    }
    return width;
  }

  int getViewedBarCount(BuildContext context, Visualization? chart) {
    double minWidth = MediaQuery.of(context).size.width * 0.90;
    int noOfBars = chart?.visualizationData.domains?.length *
            chart?.visualizationData?.measures ??
        1;
    double viewportWidth = getChartWidth(context, chart);

    if (viewportWidth > minWidth) {
      int newViewport = (minWidth /
              (noOfBars *
                  (ChartConstants.barWidth + ChartConstants.barPadding * 2)))
          .ceil();
      return newViewport;
    }
    return noOfBars;
  }

  @override
  Widget build(BuildContext context) {
    if (chart?.visualizationData == null) {
      return const Center(child: Text("Could not retrieve chart data"));
    }
    List<BarSeries<ChartData, String>> chartSeries =
        chart?.visualizationData?.chartSeries ?? [];

    double width = MediaQuery.of(context).size.width * 0.9;
    double height =
        MediaQuery.of(context).size.height * (fullScreen ? 0.9 : 0.6);

    String title = chart?.visualizationData.title ?? "Title";

    return SingleChildScrollView(
      child: SizedBox(
        width: width,
        height: height,
        child: chartSeries != null
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
                enableAxisAnimation: false,
                enableSideBySideSeriesPlacement: true,
                tooltipBehavior: TooltipBehavior(
                  enable: false,
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
                ),
                primaryXAxis: CategoryAxis(
                  interval: 1,
                  arrangeByIndex: true,
                  edgeLabelPlacement: EdgeLabelPlacement.none,
                  majorGridLines: const MajorGridLines(width: 0),
                  labelPlacement: LabelPlacement.betweenTicks,
                  labelIntersectAction: AxisLabelIntersectAction.wrap,
                ),
                series: chartSeries,
              )
            : const Center(
                child: Text("No data available"),
              ),
      ),
    );
  }
}
