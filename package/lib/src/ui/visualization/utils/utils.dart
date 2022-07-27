import 'dart:math';

import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/components/bar_chart.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/components/cascade_chart.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/components/column_chart.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/components/line_chart.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/chart/models/chart_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/custom_table/components/report_table.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/docs/components/docs.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/docs/models/doc_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/pdf/components/pdf.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/pdf/models/pdf_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/zip/components/zip.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/zip/models/zip_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VisualizationUtils {
  static String formattedDateTimeIntoString(DateTime date) {
    return date.toIso8601String().split('T')[0].trim();
  }

  static String getUid() {
    Random rnd = Random();
    const letters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const allowedChars = '0123456789$letters';
    const numberOfCodePoints = allowedChars.length;
    const codeSize = 11;
    String uid;
    int charIndex = (rnd.nextInt(10) / 10 * letters.length).round();
    uid = letters.substring(charIndex, charIndex + 1);
    for (int i = 1; i < codeSize; ++i) {
      charIndex = (rnd.nextInt(10) / 10 * numberOfCodePoints).round();
      uid += allowedChars.substring(charIndex, charIndex + 1);
    }
    return uid;
  }

  static String formatDateStringToDisplayString(DateTime value) {
    String dateString = formattedDateTimeIntoString(value);
    return dateString.split(RegExp(r'-|/')).reversed.toList().join('-');
  }

  static String formatNumber(double number) {
    return NumberFormat.compact(locale: 'en_US').format(number);
  }

  static String formatDateString(String bookingDate) {
    return bookingDate.toString().contains("T")
        ? bookingDate.split("T")[0]
        : bookingDate;
  }
  static String camelize(String value, {String separator = ''}) {
    return value
        .toLowerCase()
        .replaceAllMapped(
      RegExp(r'(^|_|-)+(.)'),
          (match) => match.group(2)?.toUpperCase() ?? '',
    )
        .replaceRange(0, 1, value[0].toLowerCase());
  }

  static String uncamelize(String value, {String separator = '_'}) {
    return value.replaceAllMapped(RegExp(r'[A-Z]|\d+'), (match) {
      return "$separator${match[0]}";
    }).toUpperCase();
  }

  static Widget getVisualizationWidget({
    required Visualization visualization,
    bool fullScreen = false,
  }) {
    switch (visualization.type) {
      case "REPORT_TABLE":
        return ReportTable(visualization);
      case "CHART":
        switch (visualization.chartType) {
          case "COLUMN":
            Chart chart = visualization as Chart;
            return CustomColumnChart(
              chart,
              fullScreen: fullScreen,
            );
          case "BAR":
            Chart chart = visualization as Chart;
            return CustomBarChart(
              chart,
              fullScreen: fullScreen,
            );
          case "LINE":
            Chart chart = visualization as Chart;
            return CustomLineChart(
              chart,
              fullScreen: fullScreen,
            );
          default:
            return const Center(child: Text("Chart type not supported"));
        }
      case "CASCADE":
        CascadeChart chart = visualization as CascadeChart;
        return CustomCascadeChart(
          chart,
          fullScreen: fullScreen,
        );
      case "PDF":
        PDFModel pdf = visualization as PDFModel;
        return PDFView(pdf);
      case "ZIP":
        ZipModel zip = visualization as ZipModel;
        return ZipViewer(zip);
      case "DOC":
        DocModel doc = visualization as DocModel;
        return DocViewer(doc);
      default:
        return const Center(
            child: Text("Unknown/Unsupported visualization type"));
    }
  }
}
