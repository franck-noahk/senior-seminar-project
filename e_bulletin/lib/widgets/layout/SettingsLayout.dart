import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bulletin/models/user.dart';
import 'package:e_bulletin/widgets/layout/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsLayout extends StatefulWidget {
  const SettingsLayout({Key key}) : super(key: key);

  @override
  _SettingsLayoutState createState() => _SettingsLayoutState();
}
//TODO: Come up with settings to load & display. Followers and such.

class _SettingsLayoutState extends State<SettingsLayout> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    var userData = Provider.of<DocumentSnapshot>(context);

    return StreamBuilder(
      stream: Firestore.instance.collection('orginizations').snapshots(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        }
        int messageCount = snapshot.data.documents.length;
        if (messageCount == 0) {
          return Center(
            child: Text("No Followers"),
          );
        }
        // List<dynamic> list= userData.data['isFollowing'];
        // list.any((element) => false)

        print(userData.data['isFollowing'].toString());

        return ListView.builder(
          itemCount: messageCount,
          itemBuilder: (_, int index) {
            DocumentSnapshot document = snapshot.data.documents[index];
            DocumentReference test;
            print(document['uid'].toString());
            return Card(
              child: ListTile(
                title: Text(document['name']),
                leading: (userData.data['isFollowing']
                        .toList()
                        .contains(document['uid']))
                    ? Icon(Icons.favorite)
                    : Icon(Icons.favorite_border),
                subtitle: Text(
                    (document["fullName"] == null) ? "" : document["fullName"]),
              ),
            );
          },
        );
      },
    );

    // return Center(
    //   key: Key("TESTING"),
    //   child: Text(
    //       // (data.data['email'] == null) ? "email is null" : user.email,
    //       snapshot.data['email']),
    // );
  }
}
