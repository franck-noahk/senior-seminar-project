import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bulletin/constants.dart';
import 'package:e_bulletin/models/user.dart';
import 'package:e_bulletin/widgets/layout/loading.dart';
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
    var userData = Provider.of<DocumentSnapshot>(context);

    return StreamBuilder(
      stream: Firestore.instance.collection('orginizations').snapshots(),
      builder: (BuildContext context, orgSnapshot) {
        if (!orgSnapshot.hasData) {
          return Loading();
        }
        int messageCount = orgSnapshot.data.documents.length;
        if (messageCount == 0) {
          return Center(
            child: Text("No Followers"),
          );
        }
        // List<dynamic> list= userData.data['isFollowing'];
        // list.any((element) => false)

        print(userData.data['isFollowing'].toString());

        return StreamBuilder(
            stream: user.db.document,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Loading();
              }
              return ListView.builder(
                key: saveMe,
                itemCount: messageCount,
                itemBuilder: (_, int index) {
                  DocumentSnapshot document = orgSnapshot.data.documents[index];

                  List<dynamic> data = snapshot.data['isFollowing'];
                  String looking = document['uid'];
                  return Card(
                    child: ListTile(
                      title: Text(document['name']),
                      leading: (snapshot.data['isFollowing']
                              .toList()
                              .contains(document['uid']))
                          ? Icon(Icons.favorite)
                          : Icon(Icons.favorite_border),
                      subtitle: Text((document["fullName"] == null)
                          ? ""
                          : document["fullName"]),
                      onTap: () async {
                        if (snapshot.data['isFollowing']
                            .toList()
                            .contains(document['uid'])) {
                          await user.removeFollower(document['uid']);
                        } else {
                          await user.addFollower(document['uid']);
                        }
                        setState(() {});
                      },
                    ),
                  );
                },
              );
            });
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
