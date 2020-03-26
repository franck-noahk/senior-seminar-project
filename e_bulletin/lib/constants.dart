import 'package:e_bulletin/widgets/layout/SettingsLayout.dart';
import 'package:e_bulletin/widgets/layout/UpCommingEventsList.dart';
import 'package:flutter/material.dart';

int screen = 0;
int maxPages = 2;

//Color PRIMARY_COLOR = Color(Material);
// Color SECONDARY_COLOR = COLOR();
ThemeData defaultTheme = new ThemeData(
    primaryColor: Colors.red,
    accentColor: Colors.greenAccent,
    appBarTheme: AppBarTheme(
      elevation: 5.0,
    ));
List<Widget> layoutWidgetArr = [
  UpcommingEventsList(),
  SettingsLayout(),
];
String uid = "8buhsULwXsUrgsmYbIjlQyKwWOH3";
var isFollowing = ["orginizations/PMLryvlhXM7GJwUNbb38"];
// FirebaseUser currentUser;
// FirebaseAuth auth = FirebaseAuth.instance;

// Future<void> getcurrentUser() async {
//   currentUser = await auth.currentUser();
//   print(currentUser);
// }
