import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_data.dart';

class PDFData extends VisualizationData {
  final String link;
  late String downloadLink;
  @override
  final String title;

  PDFData({required this.link, required this.title})
      : super(analyticsData: {}, filtersConfig: []);

  void sanitizeDownloadLink() {
    String replaceString = "uc?id=";
    downloadLink =
        link.replaceAllMapped(RegExp('(file/d/)'), (match) => replaceString);
    downloadLink = downloadLink.replaceAllMapped(
        RegExp(r'(\/view).*$'), (match) => "&export=download");
  }

  @override
  drawVisualization() {
    sanitizeDownloadLink();
  }
}
