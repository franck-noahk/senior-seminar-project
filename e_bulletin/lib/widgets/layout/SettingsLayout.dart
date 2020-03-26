import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bulletin/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsLayout extends StatefulWidget {
  const SettingsLayout({Key key}) : super(key: key);

  @override
  _SettingsLayoutState createState() => _SettingsLayoutState();
}

class _SettingsLayoutState extends State<SettingsLayout> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    var snapshot = Provider.of<DocumentSnapshot>(context);
    return Center(
      key: Key("TESTING"),
      child: Text(
          // (data.data['email'] == null) ? "email is null" : user.email,
          snapshot.data['email']),
    );
  }
}
