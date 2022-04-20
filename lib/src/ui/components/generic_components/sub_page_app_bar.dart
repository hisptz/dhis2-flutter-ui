import 'package:dhis2_flutter_ui/src/ui/core/app_contants.dart';
import 'package:flutter/material.dart';

class SubPageAppBar extends StatelessWidget {
  const SubPageAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  onNavigateToHome(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
      backgroundColor: AppConstants.appDefaultColor,
      actions: [
        Visibility(
          child: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => onNavigateToHome(context)),
        )
      ],
    );
  }
}
