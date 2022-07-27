import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_data.dart';

class ZipData extends VisualizationData {
  ZipData() : super(analyticsData: {}, filtersConfig: []);

  void sanitizeDownloadLink() {}

  @override
  drawVisualization() {
    sanitizeDownloadLink();
  }
}
