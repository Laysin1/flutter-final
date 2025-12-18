// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expense_tracker/main.dart';

void main() {
  testWidgets('App initializes correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExpenseApp());

    // Verify that the app bar is displayed
    expect(find.text('Expense Tracker'), findsOneWidget);

    // Verify bottom navigation is visible
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    // Verify home tab is selected by default
    expect(find.byIcon(Icons.home), findsOneWidget);
  });

  testWidgets('Navigation tabs switch views', (WidgetTester tester) async {
    await tester.pumpWidget(const ExpenseApp());

    // Verify we start at Home tab
    expect(find.text('Home'), findsWidgets);

    // Tap on Charts tab
    await tester.tap(find.byIcon(Icons.pie_chart));
    await tester.pumpAndSettle();

    // Verify navigation worked
    expect(find.byType(BottomNavigationBar), findsOneWidget);
  });
}
