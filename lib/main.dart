import 'package:flutter/material.dart';
import 'app/presentation/lunch_date_screen.dart';
import 'package:device_preview/device_preview.dart';

void main() => runApp(DevicePreview(
  enabled: true,
  builder: (context) => MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: const ChooseLunchDateScreen(),
    );
  }
}
