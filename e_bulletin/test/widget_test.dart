// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:e_bulletin/constants.dart';
import 'package:e_bulletin/models/user.dart';
import 'package:e_bulletin/widgets/layout/SettingsLayout.dart';
import 'package:e_bulletin/widgets/pages/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:e_bulletin/main.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('Testing Sign-in Page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    await tester.pump();
    await tester.pumpWidget(MaterialApp(
      title: 'E-Bulletin Sign in Page',
      theme: defaultTheme,
      home: SignIn(),
    ));
    expect(find.byType(Form), findsOneWidget);
    expect(find.byType(TextFormField), findsWidgets);
  });

  // testWidgets('Bottom nav buttons', (WidgetTester tester) async {
  //   await tester.pumpWidget(MaterialApp(
  //     title: 'E-Bulletin',
  //     theme: defaultTheme,
  //     home: MyHomePage(title: 'E-Bulliten', prompt: "SignOut"),
  //   ));
  //   await tester.pump();
  //   final gearIcon = find.byIcon(Icons.settings);
  //   final calIcon = find.byIcon(Icons.calendar_today);
  //   expect(gearIcon, findsOneWidget);
  //   expect(calIcon, findsOneWidget);
  //   var textFinder = find.byType(BottomNavigationBarItem);
  //   expect(textFinder, findsWidgets);

  //   await tester.tap(gearIcon);
  //   await tester.pump();
  //   var nameFinder = find.widgetWithText(Center, "Testing");
  //   expect(nameFinder, findsOneWidget);

  //   await tester.tap(calIcon);
  //   await tester.pump();
  //   textFinder = find.byType(Text);
  //   expect(textFinder, findsWidgets);
  // });
}
