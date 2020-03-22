import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = '';
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
        children: <Widget>[
          Form(
              child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: true,
                maxLines: 1,
                decoration: InputDecoration(hintText: "Email"),
                onChanged: (val) => setState(() => email = val),
                validator: (value) => isValidEmail(value),
              ),
              TextFormField(
                autofocus: true,
                maxLines: 1,
                obscureText: true,
                decoration: InputDecoration(hintText: "Password"),
                onChanged: (val) => setState(() => password = val),
              ),
            ],
          ))
        ],
      )),
    );
  }
}

isValidEmail(String value) {
  if (value.isEmpty) {
    String fillOut =  "Please fill out email field.";
    return fillOut;
  }
  if (!value.contains('@') ||
      !(value.contains('.com') ||
          value.contains('.net') ||
          value.contains('.org') ||
          value.contains('.edu'))) {
    String valid = "Please enter a valid email address.";
    return valid;
  }

  return null;
}
