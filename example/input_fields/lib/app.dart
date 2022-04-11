import 'package:flutter/material.dart';
import 'package:input_fields/home/HomePage.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'DHIS2 INPUT FIELDS Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dhis2 Input Fields Demo Home Page'),
    );
  }
}
