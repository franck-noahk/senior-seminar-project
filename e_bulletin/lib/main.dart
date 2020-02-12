import 'dart:developer';

import 'package:e_bulletin/widgets/layout/UpCommingEventsList.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Bulletin',
      home: MyHomePage(title: 'E-Bulliten'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: layoutWidgetArr[screen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screen,
        
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text("Events"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text("Settings"),
            
          ),
        ],
        onTap: (pageNum) {
          log(screen.toString());
          setState(() {
            print(screen);
            screen = pageNum;
            print(screen);
          });
          log(screen.toString());
        },
      ),
    );
  }
}
