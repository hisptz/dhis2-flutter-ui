import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/components/legend_item.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/models/chart_data.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/models/chart_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/constants/chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../utils/chart_utils.dart';

class CustomColumnChart extends StatelessWidget {
  final Chart? chart;
  final bool? horizontal;
  final bool fullScreen;

  CustomColumnChart(
    this.chart, {
    Key? key,
    this.horizontal,
    required this.fullScreen,
  }) : super(key: key);

  final numberFormatter = NumberFormat.compact(locale: 'en_US');

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.9;
    double height =
        MediaQuery.of(context).size.height * (fullScreen ? 0.9 : 0.6);
    if (chart?.visualizationData == null) {
      return const Center(child: Text("Could not retrieve chart data"));
    }
    int viewportCount = ChartUtils.getViewedBarCount(context, chart);
    List<ColumnSeries<ChartData, String>> chartSeries =
        chart?.visualizationData?.chartSeries ?? [];

    String title = chart?.visualizationData.title ?? "";

    return SingleChildScrollView(
      child: SizedBox(
        width: width,
        height: height,
        child: chartSeries != null
            ? SfCartesianChart(
                title: ChartTitle(
                    text: title, textStyle: const TextStyle(fontSize: 12)),
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
                    legendItemBuilder: (String name, dynamic series,
                        dynamic point, int index) {
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
              ),
      ),
    );
  }
}
