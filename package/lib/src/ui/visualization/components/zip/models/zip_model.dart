import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/zip/models/zip_data.dart';

class ZipModel extends Visualization {
  ZipModel({required String id, required String link})
      : super(resource: link, type: "ZIP", id: id);

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
