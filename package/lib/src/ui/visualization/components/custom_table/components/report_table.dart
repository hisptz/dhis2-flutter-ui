import 'package:dhis2_flutter_ui/src/ui/visualization/components/custom_table/components/table.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/custom_table/models/table_data.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';
import 'package:flutter/material.dart';

class ReportTable extends StatelessWidget {
  final Visualization? visualization;

  const ReportTable(this.visualization, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TableVisualizationData tableData = visualization?.visualizationData;
    return CustomTable(tableData);
  }
}
