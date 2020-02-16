// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:e_bulletin/constants.dart';
import 'package:e_bulletin/widgets/layout/SettingsLayout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:e_bulletin/main.dart';

void main() {
  testWidgets('Testing Home Page Load', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    final eventFinder = find.text('Events');
    final settingsFinder = find.text('Settings');
    final bottomNavBar = find.byType(BottomNavigationBar);
    // Verify that our counter starts at 0.
    expect(eventFinder, findsOneWidget);
    expect(settingsFinder, findsOneWidget);
    expect(bottomNavBar, findsOneWidget);
    // Tap the '+' icon and trigger a frame.

    // Verify that our counter has incremented.
  });

  testWidgets('Bottom nav buttons', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final gearIcon = find.byIcon(Icons.settings);
    final calIcon = find.byIcon(Icons.calendar_today);

    expect(gearIcon, findsOneWidget);
    expect(calIcon, findsOneWidget);
    var textFinder = find.byType(Text);
    expect(textFinder, findsNWidgets(3));

    await tester.tap(gearIcon);
    await tester.pump();
    var nameFinder = find.widgetWithText(Center, "Testing");
    expect(nameFinder, findsOneWidget);

    await tester.tap(calIcon);
    await tester.pump();
    textFinder = find.byType(Text);
    expect(textFinder, findsNWidgets(3));
  });
}
