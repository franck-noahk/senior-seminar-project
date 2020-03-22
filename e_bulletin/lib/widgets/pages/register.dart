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
        backgroundColor: Colors.red[700],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context).pop();
            },
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
