import 'package:collection/collection.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_data.dart';

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
