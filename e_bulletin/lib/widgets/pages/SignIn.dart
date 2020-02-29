import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SignIn extends StatelessWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    
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
        child: Text(
          "SignIn",
        ),
      ),
    );
  }
}
