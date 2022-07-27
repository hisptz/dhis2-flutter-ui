import 'package:dhis2_flutter_ui/src/ui/visualization/components/docs/models/doc_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DocViewer extends StatelessWidget {
  final DocModel doc;

  const DocViewer(this.doc, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(doc.resource);
    return InkWell(
      onTap: () {
        launchUrl(url);
      },
      child: Icon(
        Icons.description,
        color: Theme.of(context).primaryColor,
        size: 100,
      ),
    );
  }

  void _launchUrl(Uri url) async {
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }
}
