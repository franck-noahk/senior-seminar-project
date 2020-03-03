import 'dart:developer';

import 'package:e_bulletin/widgets/layout/UpCommingEventsList.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'widgets/pages/SignIn.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Bulletin',
      theme: defaultTheme,
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
    Widget myBottomNavBar = BottomNavigationBar(
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
        setState(() {
          screen = pageNum;
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: FlatButton(
              padding: EdgeInsets.all(8),
              textColor: Colors.white,
              color: Colors.red[700],
              child: Text(
                user,
                style: TextStyle(fontSize: 15.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignIn()),
                );
              },
            ),
          ),
        ],
      ),
      body: layoutWidgetArr[screen],
      bottomNavigationBar: myBottomNavBar,
    );
  }
}
