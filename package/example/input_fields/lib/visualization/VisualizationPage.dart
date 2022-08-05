import 'package:dhis2_flutter_ui/dhis2_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:input_fields/visualization/services/http_service.dart';

const visualizationsJson = [
  {
    "id": "UlfTKWZWV4u",
    "type": VisualizationTypes.chart,
    "chart": {"id": "UlfTKWZWV4u"}
  },
  {
    "id": "Tun9tJb3sQt",
    "type": VisualizationTypes.chart,
    "chart": {"id": "Tun9tJb3sQt"}
  }
];

CustomHttpService http = CustomHttpService(
    username: 'admin',
    password: 'district',
    baseUrl: 'https://play.dhis2.org/2.35.14');

class VisualizationPage extends StatefulWidget {
  const VisualizationPage({Key? key}) : super(key: key);

  @override
  State<VisualizationPage> createState() => _VisualizationPageState();
}

class _VisualizationPageState extends State<VisualizationPage> {


  List<VisualizationConfig> visualizations = [];

  @override
  void initState() {
    setState(() {
      visualizations = visualizationsJson
          .map((visualization) => VisualizationConfig.fromJson(visualization))
          .toList();
    });
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Visualization'),
        ),
        body: ListView.builder(
            itemBuilder: (context, index) => VisualizationContainer(
                  visualizations[index],
                  httpService: http,
                ),
            itemCount: visualizations.length));
  }
}
