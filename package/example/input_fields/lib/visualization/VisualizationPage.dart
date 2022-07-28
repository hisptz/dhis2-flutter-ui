import 'package:dhis2_flutter_ui/dhis2_flutter_ui.dart';

import 'package:flutter/material.dart';
import 'package:input_fields/visualization/services/http_service.dart';

const visualizationsJson = [
  {
    "id": "ABAT25fOGK4",
    "type": VisualizationTypes.chart,
    "chart": {"id": "LW0O27b7TdD"}
  },
  // {
  //   "id": "IvXcdp2cFHa",
  //   "type": VisualizationTypes.chart,
  //   "chart": {"id": "IvXcdp2cFHa"}
  // }
];

class VisualizationPage extends StatefulWidget {
  const VisualizationPage({Key? key}) : super(key: key);

  @override
  State<VisualizationPage> createState() => _VisualizationPageState();
}

class _VisualizationPageState extends State<VisualizationPage> {
  CustomHttpService http = CustomHttpService(
      username: 'admin',
      password: 'district',
      baseUrl: 'https://play.dhis2.org/2.35.14');

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
    print(visualizations);
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
