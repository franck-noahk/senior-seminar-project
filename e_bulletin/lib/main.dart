import 'package:e_bulletin/models/user.dart';
import 'package:flutter/material.dart';
import 'backend/firebase.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'widgets/pages/SignIn.dart';

void main() async {
  // await getcurrentUser();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: Wrapper(),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    if (user != null) {
      return StreamProvider<DocumentSnapshot>.value(
        value: Provider.of<User>(context).db.document,
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
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    AuthService _auth = new AuthService();
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
      bottomNavigationBar: myBottomNavBar,
    );
  }
}
