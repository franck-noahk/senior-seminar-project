import 'package:e_bulletin/widgets/layout/SettingsLayout.dart';
import 'package:e_bulletin/widgets/layout/UpCommingEventsList.dart';
import 'package:flutter/material.dart';

int screen = 0;
int MAX_PAGES = 2;

List<Widget> layoutWidgetArr = [
  UpcommingEventsList(),
  SettingsLayout(),
];
