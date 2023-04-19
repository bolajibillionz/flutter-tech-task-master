import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/app/models/response_model/get_ingredient_response_model.dart';
import 'package:tech_task/app/presentation/ingredient_screen.dart';
import 'package:tech_task/app/presentation/lunch_date_screen.dart';

void main() {
  testWidgets('Screen should have a title', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ChooseLunchDateScreen(),
    ));

    Finder title = find.text('Recipe App');
    expect(title, findsOneWidget);
  });
  testWidgets('Screen should have a text', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ChooseLunchDateScreen(),
    ));

    Finder title = find.text('Select Date of Lunch');
    expect(title, findsOneWidget);
  });
  testWidgets('Screen should have a date picker container',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ChooseLunchDateScreen(),
    ));

    Finder datePickerContainer = find.byKey(const ValueKey('date_picker'));
    expect(datePickerContainer, findsOneWidget);
  });
  testWidgets('Screen should have a get ingredient button',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ChooseLunchDateScreen(),
    ));

    Finder button = find.byType(ElevatedButton);
    expect(button, findsOneWidget);
  });
}
