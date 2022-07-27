import 'package:collection/collection.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/custom_table/models/table_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TableDataSource extends DataGridSource {
  late List<DataGridRow> _rows;

  String _getValue(
      {required String column, required String row, required List currentRow}) {
    Map? data = currentRow.firstWhereOrNull(
        (data) => data['column'] == column && data['row'] == row);

    return data?["value"] ?? "";
  }

  List<DataGridRow> _getRows(
      {required List tableData,
      required List tableRows,
      required List tableColumns}) {
    List<DataGridRow> rows = tableRows.mapIndexed<DataGridRow>((index, row) {
      return DataGridRow(
          cells: tableColumns
              .map<DataGridCell>((column) => DataGridCell(
                  columnName: column['id'],
                  value: _getValue(
                      row: row['id'],
                      column: column['id'],
                      currentRow: tableData[index] ?? [])))
              .toList());
    }).toList();

    return rows;
  }

  TableDataSource(
      {required tableData, required tableRows, required tableColumns}) {
    _rows = _getRows(
        tableData: tableData, tableRows: tableRows, tableColumns: tableColumns);
  }

  @override
  get rows => _rows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((cell) {
      bool isHeader = cell.columnName == 'header';
      return Container(
        color: isHeader ? const Color(0xFFF5F5F5) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Container(
              alignment: isHeader ? Alignment.centerLeft : Alignment.center,
              child: Text(cell.value.toString())),
        ),
      );
    }).toList());
  }
}

class CustomTable extends StatelessWidget {
  final TableVisualizationData visualizationData;

  const CustomTable(this.visualizationData, {Key? key}) : super(key: key);

  _getColumns() {
    List columns = visualizationData.tableColumns;

    return columns.map((column) {
      bool isHeader = column['id'] == "header";
      return GridColumn(
        columnName: column['id'],
        minimumWidth: isHeader ? 120 : 60,
        label: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(child: Text(column['name'])),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List tableData = visualizationData.tableData;
    List tableColumns = visualizationData.tableColumns;
    List tableRows = visualizationData.tableRows;
    List tableFilters = visualizationData.filters;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SfDataGridTheme(
        data: SfDataGridThemeData(
          headerColor: const Color(0xFFF5F5F5),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Center(
                child: Text(
                  tableFilters.join(" - "),
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              child: SfDataGrid(
                  columnWidthMode: ColumnWidthMode.fill,
                  allowColumnsResizing: true,
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  frozenColumnsCount: 1,
                  source: TableDataSource(
                      tableData: tableData,
                      tableColumns: tableColumns,
                      tableRows: tableRows),
                  columns: _getColumns()),
            ),
          ],
        ),
      ),
    );
  }
}
