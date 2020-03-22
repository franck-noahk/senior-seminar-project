import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Bulliten Register New User"),
        backgroundColor: Colors.red,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: FlatButton(
              color: Colors.red[700],
              textColor: Colors.white,
              child: Row(
                children: [
                  Icon(Icons.person),
                  Text("Sing-in"),
                ],
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
      body: Container(
          child: Column(
        children: <Widget>[],
      )),
    );
  }
}
