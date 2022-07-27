import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/utils/utils.dart';
import 'package:flutter/material.dart';

class VisualizationFullScreenPage extends StatelessWidget {
  const VisualizationFullScreenPage({
    Key? key,
    required this.visualization,
  }) : super(key: key);
  final Visualization visualization;

  void onExitFullScreen(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    DateTime? lastUpdated = visualization.lastUpdated;
    bool? fromNetwork = visualization.fromNetwork;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            Positioned.fill(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.98,
                    child: VisualizationUtils.getVisualizationWidget(
                        visualization: visualization, fullScreen: true)),
                !fromNetwork
                    ? Text(
                        'Last updated: ${VisualizationUtils.formatDateStringToDisplayString(lastUpdated)}',
                        style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.blueGrey),
                      )
                    : Container()
              ],
            )),
            Positioned(
                right: 0,
                height: 32.0,
                width: 32.0,
                child: InkWell(
                  onTap: () => onExitFullScreen(context),
                  child: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).primaryColor.withOpacity(0.1),
                    child: Center(
                      child: Icon(
                        Icons.fullscreen_exit,
                        color: Theme.of(context).primaryColor,
                        size: 24.0,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
