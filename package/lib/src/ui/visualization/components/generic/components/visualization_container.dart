import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/components/visualization_full_screen_page.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/components/generic/models/visualization_model.dart';
import 'package:dhis2_flutter_ui/src/ui/visualization/utils/utils.dart';
import 'package:flutter/material.dart';

class VisualizationContainer extends StatefulWidget {
  final Visualization? visualization;

  const VisualizationContainer(this.visualization, {Key? key})
      : super(key: key);

  @override
  State<VisualizationContainer> createState() => _VisualizationContainerState();
}

class _VisualizationContainerState extends State<VisualizationContainer> {
  bool _loading = false;
  late Visualization? _visualization;

  Widget visualizationWidget() {
    return VisualizationUtils.getVisualizationWidget(
        visualization: widget.visualization!, fullScreen: false);
  }

  void onOpenFullScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VisualizationFullScreenPage(
            visualization: widget.visualization!,
          ),
        ));
  }

  Future<void> getData() async {
    setState(() {
      _loading = true;
    });
    await _visualization?.getData();
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      _visualization = widget.visualization;
    });
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime? lastUpdated = _visualization?.lastUpdated;
    bool? fromNetwork = _visualization?.fromNetwork ?? true;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.62,
      width: MediaQuery.of(context).size.width * 0.90,
      child: _loading
          ? const Center(
              child: SizedBox(
                  height: 20, width: 20, child: CircularProgressIndicator()))
          : Stack(
              children: [
                Positioned.fill(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: visualizationWidget(),
                    ),
                    !fromNetwork
                        ? Text(
                            'Last updated: ${VisualizationUtils.formatDateStringToDisplayString(lastUpdated!)}',
                            style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.blueGrey),
                          )
                        : Container()
                  ],
                )),
                Visibility(
                  visible: widget.visualization?.type != 'ZIP',
                  child: Positioned(
                      right: 0,
                      height: 32.0,
                      width: 32.0,
                      child: InkWell(
                        onTap: () => onOpenFullScreen(context),
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Center(
                            child: Icon(
                              Icons.fullscreen,
                              color: Theme.of(context).primaryColor,
                              size: 24.0,
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
    );
  }
}
