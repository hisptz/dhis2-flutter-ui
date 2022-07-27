import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/http_service.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/utils/utils.dart';
import 'package:flutter/foundation.dart';

class Visualization {
  late String id;
  late String name;
  late String type;
  late String resource;
  late List<Map> dataDimensionItems;
  late bool userOrganisationUnit;
  late bool userOrganisationUnitChildren;
  late bool userOrganisationUnitGrandChildren;
  late List<Map> periods;
  late List<Map> organisationUnits;
  late List<int> organisationUnitLevels;
  late Map<String, bool> relativePeriods;
  late List<Map> categoryDimensions;
  late List<Map<String, dynamic>> columns;
  late List<Map<String, dynamic>> rows;
  late List<Map<String, dynamic>> filters;
  late Map? analyticsData;
  bool dataError = false;
  bool configError = false;
  late String? chartType;
  late String? series;
  late String? category;
  late dynamic visualizationData;
  DateTime lastUpdated = DateTime.now();
  bool fromNetwork = true;
  HttpService http;

  Visualization(
      {required this.id,
      required this.type,
      required this.resource,
      required this.http});

  Visualization.fromJson(Map<String, dynamic> json,
      {required this.id,
      required this.type,
      required this.resource,
      required this.http}) {
    name = json['name'];
    columns = json['columns'].cast<Map<String, dynamic>>();
    rows = json['rows'].cast<Map<String, dynamic>>();
    filters = json['filters'].cast<Map<String, dynamic>>();
    dataDimensionItems = json['dataDimensionItems'].cast<Map>();
    periods = json['periods'].cast<Map>();
    organisationUnits = json['organisationUnits'].cast<Map>();
    categoryDimensions = json['categoryDimensions'].cast<Map>();
    relativePeriods = json['relativePeriods'].cast<String, bool>();
    organisationUnitLevels = json['organisationUnitLevels'].cast<int>();
    chartType = json['type'];
    series = json['series'];
    category = json['category'];
    userOrganisationUnit = json['userOrganisationUnit'];
    userOrganisationUnitChildren = json['userOrganisationUnitChildren'];
    userOrganisationUnitGrandChildren =
        json['userOrganisationUnitGrandChildren'];
  }

  get width => null;

  get domains => null;

  get measures => null;

  List<String> getPeriods() {
    List<String> pe = periods.map((item) => item['id'] as String).toList();
    Map<String, bool> relativePeriods = this.relativePeriods;
    relativePeriods.removeWhere((key, value) => !value);
    if (relativePeriods.isNotEmpty) {
      pe.addAll(relativePeriods.keys.map(VisualizationUtils.uncamelize));
    }

    if (pe.isEmpty) {
      pe.addAll([]); //TODO: Find a way to handle this
    }

    return pe;
  }

  List<String> getDataItems() {
    return dataDimensionItems.map((item) {
      String key = VisualizationUtils.camelize(item['dataDimensionItemType']);
      return item[key]['id'] as String;
    }).toList();
  }

  List<String> getOrganisationUnits() {
    List<String> ous = [];

    ous.addAll(organisationUnits.map((item) => item['id'] as String));

    if (userOrganisationUnit) {
      ous.add('USER_ORGUNIT');
    }

    if (userOrganisationUnitChildren) {
      ous.add('USER_ORGUNIT_CHILDREN');
    }

    if (userOrganisationUnitGrandChildren) {
      ous.add('USER_ORGUNIT_GRANDCHILDREN');
    }

    if (organisationUnitLevels.isNotEmpty) {
      ous.addAll(organisationUnitLevels.map((item) => 'LEVEL-$item').toList());
    }

    return ous;
  }

  List<Map<String, List<String>>> getCategories() {
    return categoryDimensions.map((item) {
      Map category = item["category"];
      List<Map> categoryOptions = item['categoryOptions'].cast<Map>();
      return {
        "${category["id"]}":
            categoryOptions.map((item) => item["id"] as String).toList()
      };
    }).toList();
    //add map entries to dimension
  }

  Map<String, List<String>> getDimensions() {
    Map<String, List<String>> dimensions = {};

    List<String> columns =
        this.columns.map((item) => item["id"] as String).toList();
    List<String> rows = this.rows.map((item) => item["id"] as String).toList();

    if (columns.contains("dx") || rows.contains("dx")) {
      dimensions["dx"] = getDataItems();
    }

    if (columns.contains("pe") || rows.contains("pe")) {
      dimensions["pe"] = getPeriods();
    }

    if (columns.contains("ou") || rows.contains("ou")) {
      dimensions["ou"] = getOrganisationUnits();
    }

    List<Map<String, List<String>>> categories = getCategories();

    if (categories.isNotEmpty) {
      for (Map element in categories) {
        if (columns.contains(element.keys.first) ||
            rows.contains(element.keys.first)) {
          dimensions[element.keys.first] = element.values.first;
        }
      }
    }

    return dimensions;
  }

  Map<String, List<String>> getFilters() {
    Map<String, List<String>> filter = {};
    List<String> filters =
        this.filters.map((item) => item["id"] as String).toList();

    if (filters.isNotEmpty) {
      if (filters.contains("dx")) {
        filter["dx"] = getDataItems();
      }
      if (filters.contains("pe")) {
        filter["pe"] = getPeriods();
      }
      if (filters.contains("ou")) {
        filter["ou"] = getOrganisationUnits();
      }

      List<Map<String, List<String>>> categories = getCategories();

      if (categories.isNotEmpty) {
        for (Map element in categories) {
          if (filters.contains(element.keys.first)) {
            filter[element.keys.first] = element.values.first;
          }
        }
      }
    }

    return filter;
  }

  Future<Map<String, dynamic>?> getJsonFromOnline() async {
    try {
      String url = 'api/$resource/$id';
      var response = await http.httpGet(url);
      return http.getDataFromResponse(response);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      configError = true;
    }
  }

  Future<void> getData() async {
    String url = 'api/analytics';

    if (http == null) {
      return;
    }

    Map<String, List<String>> dimensions = getDimensions();
    Map<String, List<String>> filters = getFilters();

    Map<String, String> formattedDimensions =
        dimensions.map((key, value) => MapEntry(key, value.join(";")));
    Map<String, String> formattedFilters =
        filters.map((key, value) => MapEntry(key, value.join(";")));
    var response = await http.httpGet(url, queryParameters: {
      "dimension": formattedDimensions.entries
          .map((e) => "${e.key}:${e.value}")
          .join(","),
      "filter":
          formattedFilters.entries.map((e) => "${e.key}:${e.value}").join(",")
    });

    analyticsData = http.getDataFromResponse(response);
  }

  Future<Visualization?> get() async {
    Map<String, dynamic>? data = await getJsonFromOnline();
    if (data != null) {
      return Visualization.fromJson(data,
          id: id, resource: resource, type: type, http: http);
    }
    return null;
  }
}
