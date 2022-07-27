import 'package:dhis2_flutter_ui/src/ui/visualization/components/docs/models/doc_data.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';

class DocModel extends Visualization {
  DocModel({required String id, required String link})
      : super(resource: link, type: "DOC", id: id);

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
