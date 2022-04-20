import 'package:flutter/material.dart';

class CircularProcessLoader extends StatelessWidget {
  const CircularProcessLoader({Key? key, this.color, this.size})
      : super(key: key);
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                strokeWidth: size ?? 4,
                valueColor: AlwaysStoppedAnimation(color ?? Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }
}
