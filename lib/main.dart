import 'package:flutter/material.dart';
import 'app/presentation/lunch_date_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: const ChooseLunchDateScreen(),
    );
  }
}
