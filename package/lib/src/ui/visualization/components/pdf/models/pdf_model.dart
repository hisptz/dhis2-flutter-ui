import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';

import 'pdf_data.dart';

class PDFVisualizationModel extends Visualization {
  final String link;
  final String title;

  PDFVisualizationModel({required String id, required this.link, required this.title})
      : super(id: id, type: "PDF", resource: "");

  @override
  Future<void> getData() async {
    visualizationData = PDFData(link: link, title: title);
  }

  @override
  Future<Visualization?> get() async {
    name = title;
    return this;
  }
}
