import 'package:dhis2_flutter_ui/src/main_directive.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onTap,
      required this.label,
      this.highlightedColor = Colors.white10})
      : super(key: key);

  final VoidCallback onTap;
  final String label;
  final dynamic highlightedColor;

// ignore: todo
  /// TODO: add suppport for icon button
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 10.0,
      ),
      child: MaterialCard(
        borderRadius: 5.0,
        elevation: 2.0,
        body: InkWell(
            highlightColor: highlightedColor,
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              alignment: Alignment.center,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 15.0,
              ),
              child: Text(label),
            )),
      ),
    );
  }
}
