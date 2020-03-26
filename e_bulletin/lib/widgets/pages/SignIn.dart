import 'package:e_bulletin/backend/firebase.dart';
import 'package:e_bulletin/widgets/layout/loading.dart';
import 'package:e_bulletin/widgets/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AuthService _authS = AuthService();

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    String userName = "";
    String password = "";
    bool isLoading = false;

    final _formKey = GlobalKey<FormState>();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return (isLoading)
        ? Loading()
        : Scaffold(
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
                key: _formKey,
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
                        validator: (value) => isValidEmail(value),
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
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            dynamic result =
                                await _authS.signInEmail(userName, password);
                            if (result == null)
                              setState(() {
                                isLoading = false;
                              });
                          }
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
