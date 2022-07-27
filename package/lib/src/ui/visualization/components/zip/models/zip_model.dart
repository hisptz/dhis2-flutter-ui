import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/zip/models/zip_data.dart';

import '../../generic/models/http_service.dart';

class ZipVisualizationModel extends Visualization {
  ZipVisualizationModel(
      {required String id, required String link, required HttpService http})
      : super(resource: link, type: "ZIP", id: id, http: http);

  @override
  get() async {
    name = id;
    return this;
  }

  @override
  Future<void> getData() async {
    visualizationData = ZipData();
  }
}
