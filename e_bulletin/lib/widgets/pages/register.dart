import 'package:e_bulletin/backend/firebase.dart';
import 'package:e_bulletin/widgets/layout/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    String passwordConfirm = "";
    bool isLoading = false;
    final _formKey = GlobalKey<FormState>();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    AuthService _auth = new AuthService();
    return (isLoading)
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Register New User"),
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
                        decoration: InputDecoration(hintText: "Email"),
                        onChanged: (val) => email = val,
                        validator: (value) => isValidEmail(value),
                      ),
                      TextFormField(
                        autofocus: true,
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(hintText: "Password"),
                        onChanged: (val) => password = val,
                        validator: (val) => (val.length < 6)
                            ? "Please enter a longer password"
                            : null,
                      ),
                      TextFormField(
                        autofocus: true,
                        maxLines: 1,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password Confirmation",
                        ),
                        onChanged: (val) => passwordConfirm = val,
                        validator: (val) => (val.length < 6)
                            ? "Please enter a longer password"
                            : (val != password)
                                ? "Please Make sure the passwords Match"
                                : null,
                      ),
                      RaisedButton(
                        color: Colors.red[700],
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            dynamic result = await _auth.signUpEmail(
                              email,
                              password,
                            );
                            if (result != null) {
                              Navigator.pop(context);
                            }
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                        child: Text("Register"),
                      )
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
