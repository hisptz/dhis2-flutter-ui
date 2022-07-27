import 'package:dhis2_flutter_ui/src/ui/visualization/components/pdf/models/pdf_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomPDFViewer extends StatelessWidget {
  final PDFVisualizationModel pdf;

  const CustomPDFViewer(this.pdf, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pdf.visualizationData.drawVisualization();
    return SfPdfViewer.network(
      pdf.visualizationData.downloadLink,
      enableDoubleTapZooming: true,
      interactionMode: PdfInteractionMode.pan,
    );
  }
}
