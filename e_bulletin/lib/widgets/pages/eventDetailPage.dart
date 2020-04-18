import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bulletin/backend/firebase.dart';
import 'package:e_bulletin/models/user.dart';
import 'package:e_bulletin/widgets/layout/loading.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';

class EventDetailPage extends StatefulWidget {
  EventDetailPage({
    Key key,
    this.uuid,
  }) : super(key: key);
  String uuid = "initial";
  @override
  _EventPageDetailState createState() => _EventPageDetailState(this.uuid);
}

class _EventPageDetailState extends State<EventDetailPage> {
  _EventPageDetailState(this.uuid);
  String uuid;

  @override
  Widget build(BuildContext context) {
    print("Looking up " + uuid);
    return StreamBuilder(
        stream: Firestore.instance
            .collection('events')
            .document(uuid)
            .get()
            .asStream(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          print("Snaphsot data " + snapshot.data.data.toString());
          return (snapshot.hasData)
              ? Scaffold(
                  appBar: AppBar(),
                  body: Container(
                    child: Column(
                      children: <Widget>[
                        Text(
                          snapshot.data.data['name'].toString(),
                          style: TextStyle(),
                        ),
                        Text(
                          (snapshot.data.data['event_time'] != null)
                              ? Jiffy(snapshot.data.data['event_time'].toDate())
                                  .yMMMMEEEEdjm
                              : "no message",
                          style: TextStyle(),
                        ),
                        Text(
                          (snapshot.data.data['location'] != null)
                              ? snapshot.data.data['location']
                              : "No Location specified.",
                          style: TextStyle(),
                        ),
                        Text(
                          (snapshot.data.data['description'] == null)
                              ? "No Description given"
                              : snapshot.data.data['description'],
                          style: TextStyle(),
                        ),
                        RaisedButton(onPressed: toggleRSVP()),
                      ],
                    ),
                  ),
                )
              : Loading();
        });
  }
}

toggleRSVP() {}
