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
import 'widgets/pages/makeEvent.dart';


//This is how the app starts. and it calls the Statefull Widget MyApp
void main() async {
  runApp(MyApp());
}

//Each Stateful widget extends calls a state.
class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    //Builds listends to a stream of data from internet
    return StreamProvider<User>.value(
      //Spacifically a stream of who is signed in
      value: AuthService().user,
      //displays/calls another widget called Wrapper
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
  Widget build(BuildContext context) {
    //This is a way of having a single user that is passed around through the app
    var user = Provider.of<User>(context);
    //user is Signed in
    if (user != null) {
      return StreamProvider<DocumentSnapshot>.value(
        value: user.db.document,
        child: MaterialApp(
          title: 'E-Bulletin',
          theme: defaultTheme,
          home: MyHomePage(
            title: 'E-Bulliten',
          ),
        ),
      );
    } else { //User needs to sign in.
      return MaterialApp(
        title: 'E-Bulletin Sign in Page',
        theme: defaultTheme,
        //Custom Written enviornment found in widgets/pages/SignIn.dart
        home: SignIn(),
      );
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Firestore _db = Firestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();

  StreamSubscription iosSubscription;
  //Overwriting init to handel notifications when Signed in. 
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
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    AuthService _auth = new AuthService();

    return StreamBuilder(
        stream: user.db.document,
        builder: (context, snapshot) {
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
                      "Sign Out",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    onPressed: () {
                      _auth.signOut();
                    },
                  ),
                ),
              ],
            ),
            //This is what is displayed between the top & nav bar. See Constants.dart
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
                setState(() {
                  screen = pageNum;
                });
              },
            ),
            //should only display if the user is admin
            floatingActionButton: (snapshot.data['isAdmin'])
                ? FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MakeEvent(),
                        ),
                      );
                    },
                    label: Text("Create new Event"),
                    isExtended: true,
                  )
                : null,
          );
        });
  }
}
