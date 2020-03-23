import 'package:e_bulletin/backend/firebase.dart';
import 'package:e_bulletin/constants.dart';
import 'package:e_bulletin/widgets/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

AuthService _authS = AuthService();

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userName = "";
    String password = "";

    return Scaffold(
      appBar: AppBar(
        title: Text("E-Bulliten Sign-in"),
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
                  Text("Register"),
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                );
              },
            ),
          )
        ],
      ),
      body: Center(
        child: Form(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  autofocus: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "E-Mail",
                  ),
                  onChanged: (String changes) {
                    userName = changes;
                  },
                ),
                TextFormField(
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                  onChanged: (String changes) {
                    password = changes;
                  },
                  obscureText: true,
                ),
                RaisedButton(
                  child: Text("Sign-in"),
                  color: Colors.red[700],
                  onPressed: () async {
                    await trySignIn(userName, password, context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> trySignIn(
  String userName,
  String password,
  BuildContext context,
) async {
  dynamic result = await _authS.signInEmail(userName, password);

  if (result == null) {
    print("error signing in");
  } else {
    print("signed in");
    print(result.uid);
  }

  // Navigator.pop(context);
}

isValidEmail(String value) {
  if (value.isEmpty) {
    String fillOut = "Please fill out email field.";
    return fillOut;
  }
  if (!value.contains('@') ||
      !(value.contains('.com') ||
          value.contains('.net') ||
          value.contains('.org') ||
          value.contains('.edu')) ||
      value.contains(" ")) {
    String valid = "Please enter a valid email address.";
    return valid;
  }

  return null;
}
