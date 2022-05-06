import 'package:flutter/material.dart';



class Application {
  String id;
  String label;
  String iconPath;
  List<String> userGroups;
  Widget page;

  Application(
      {required this.id,
      required this.label,
      required this.iconPath,
      required this.page,
      this.userGroups = const []});

  @override
  String toString() => label;
}
