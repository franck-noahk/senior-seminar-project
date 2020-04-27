import 'package:e_bulletin/widgets/layout/SettingsLayout.dart';
import 'package:e_bulletin/widgets/layout/UpCommingEventsList.dart';
import 'package:flutter/material.dart';

int screen = 0;
int maxPages = 2;
GlobalKey saveMe = new GlobalKey();
//Color PRIMARY_COLOR = Color(Material);
// Color SECONDARY_COLOR = COLOR();
ThemeData defaultTheme = new ThemeData(
    primaryColor: Colors.red,
    accentColor: Colors.greenAccent,
    appBarTheme: AppBarTheme(
      elevation: 5.0,
    ));
//List of pages at the bottom of screen
List<Widget> layoutWidgetArr = [
  UpcommingEventsList(),
  SettingsLayout(),
];
