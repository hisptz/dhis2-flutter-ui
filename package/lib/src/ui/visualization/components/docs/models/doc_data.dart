import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_data.dart';

class DocData extends VisualizationData {
  DocData() : super(analyticsData: {}, filtersConfig: []);

  void sanitizeDownloadLink() {}

  @override
  drawVisualization() {
    sanitizeDownloadLink();
  }
}
