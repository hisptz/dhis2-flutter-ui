import 'package:dhis2_flutter_ui/src/ui/visualization/components/docs/models/doc_data.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/http_service.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';

class DocVisualizationModel extends Visualization {
  DocVisualizationModel({required String id, required String link, required HttpService http})
      : super(resource: link, type: "DOC", id: id, http: http);

  @override
  get() async {
    name = id;
    return this;
  }

  @override
  Future<void> getData() async {
    visualizationData = DocData();
  }
}
