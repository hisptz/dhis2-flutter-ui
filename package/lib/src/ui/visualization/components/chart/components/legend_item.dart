import 'package:flutter/material.dart';

class CustomLegendItem extends StatelessWidget {
  final List chartSeries;
  final dynamic series;
  final int index;

  const CustomLegendItem(
      {required this.chartSeries,
      required this.series,
      required this.index,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(Icons.bar_chart, color: series.color, size: 24),
        Expanded(
          child: Text(
            series.legendItemText ?? "",
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
