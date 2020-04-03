import 'dart:async';
import 'dart:io';

import 'package:e_bulletin/models/user.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'backend/firebase.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'widgets/pages/SignIn.dart';

// Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
//   if (message.containsKey('data')) {
//     // Handle data message
//     final dynamic data = message['data'];
//   }

//   if (message.containsKey('notification')) {
//     // Handle notification message
//     final dynamic notification = message['notification'];
//   }

//   // Or do other work.
// }

void main() async {
  // await getcurrentUser();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: Wrapper(),
    );
  }
}

class Wrapper extends StatefulWidget {
  const Wrapper({
    Key key,
  }) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _fcm.configure(
      onMessage: (message) async {
        SnackBar snackBar = SnackBar(
          content: Text(message['notification']['title']),
          action: SnackBarAction(
              label: "Go",
              onPressed: () {
                screen = 0;
              }),
        );
        print("Message Recieved");
        Scaffold.of(saveMe.currentContext).showSnackBar(snackBar);
      },
      onLaunch: (message) async {
        print("Message is " + message['notification']['title']);
      },
      onResume: (message) async {
        print("Message is " + message['notification']['title']);
      },
      // onBackgroundMessage: myBackgroundMessageHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    if (user != null) {
      return StreamProvider<DocumentSnapshot>.value(
        value: user.db.document,
        child: MaterialApp(
          title: 'E-Bulletin',
          theme: defaultTheme,
          home: MyHomePage(
            title: 'E-Bulliten',
            prompt: "SignOut",
          ),
        ),
      );
    } else {
      return MaterialApp(
        title: 'E-Bulletin Sign in Page',
        theme: defaultTheme,
        home: SignIn(),
      );
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
    this.prompt,
  }) : super(key: key);

  final String title;
  final String prompt;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  StreamSubscription iosSubscription;

  @override
  void initState() {
    super.initState();

    if (Platform.isIOS) {
      iosSubscription = _fcm.onIosSettingsRegistered.listen((data) async {
        String token = await _fcm.getToken();
        print(token);
      });

      _fcm.requestNotificationPermissions(IosNotificationSettings(
        alert: true,
        badge: true,
        sound: true,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    AuthService _auth = new AuthService();

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
                widget.prompt,
                style: TextStyle(fontSize: 15.0),
              ),
              onPressed: () {
                _auth.signOut();
              },
            ),
          ),
        ],
      ),
      body: layoutWidgetArr[screen],
      // body:Center(child: Text("HELLO"),),
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
          setState(() {
            screen = pageNum;
          });
        },
      ),
    );
  }
}
