import 'package:e_bulletin/backend/firebase.dart';
import 'package:e_bulletin/constants.dart';
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
          // actions: <Widget>[
          //   BackButton(
          //     color: Colors.black,
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //   )
          // ],
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
                  child: Text("Submit"),
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
