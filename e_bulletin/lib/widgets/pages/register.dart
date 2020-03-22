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

isValidEmail(String value) {
  if (value.isEmpty) {
    return "Please Fill out this field.";
  }
  if (!value.contains('@') ||
      (value.contains('.com') ||
          value.contains('.net') ||
          value.contains('.edu'))) {
    return "Please enter a valid email address.";
  }

  return null;
}
