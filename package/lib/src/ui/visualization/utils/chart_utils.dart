import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/constants/chart.dart';
import 'package:flutter/material.dart';
class ChartUtils {
  static double getChartWidth(BuildContext context, Visualization? chart) {
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

  static int getViewedBarCount(BuildContext context, Visualization? chart) {
    double minWidth = MediaQuery.of(context).size.width * 0.90;
    int viewport = chart?.visualizationData.domains?.length ?? 0;
    double viewportWidth = getChartWidth(context, chart);

    if (viewportWidth > minWidth) {
      int newViewport = (minWidth /
              ((chart?.visualizationData?.chartSeries?.length ?? 1) *
                  (ChartConstants.barWidth + ChartConstants.barPadding * 2)))
          .ceil();
      return newViewport;
    }
    return viewport;
  }
}
