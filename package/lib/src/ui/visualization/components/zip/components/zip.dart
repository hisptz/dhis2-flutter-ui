import 'package:dhis2_flutter_ui/src/ui/visualization/components/zip/models/zip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ZipViewer extends StatelessWidget {
  final ZipModel zip;

  const ZipViewer(this.zip, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse(zip.resource);
    return Padding(
      padding: EdgeInsets.all(MediaQuery
          .of(context)
          .size
          .width * 0.3),
      child: InkWell(
        onTap: () {
          launchUrl(url);
        },
        child: SvgPicture.asset(
          'assets/icons/zip.svg',
          fit: BoxFit.contain,
          allowDrawingOutsideViewBox: false,
          height: 20,
        ),
      ),
    );
  }
}
