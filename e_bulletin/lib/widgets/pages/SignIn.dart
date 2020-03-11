import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
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
                    await trySignIn(userName, password);
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

void trySignIn(String userName, String password) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    await _auth.signInWithEmailAndPassword(email: userName, password: password);
  } catch (e) {
    //TODO: Handle some way to print error
  }
  //TODO: return user back to prvious page
}
