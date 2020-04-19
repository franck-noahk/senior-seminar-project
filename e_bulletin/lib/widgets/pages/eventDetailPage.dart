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
    var user = Provider.of<User>(context);
    bool isRSVPD;
    print("Looking up " + uuid);
    return StreamBuilder(
      stream: Firestore.instance
          .collection('events')
          .document(uuid)
          .collection('response')
          .document('rsvp')
          .get()
          .asStream(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> responseSnapshot) {
        if (responseSnapshot.hasError || !responseSnapshot.hasData) {
          return Scaffold(
            body: Loading(),
            appBar: AppBar(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('events')
                .document(uuid)
                .get()
                .asStream(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              // print("Snaphsot data " + snapshot.data.data.toString());
              bool toRSVP = snapshot.hasData &&
                  responseSnapshot.hasData &&
                  responseSnapshot.data.data != null &&
                  (responseSnapshot.data.data[user.uid] == 'isNotComming' ||
                      responseSnapshot.data.data[user.uid] == null);
              return (snapshot.hasData && responseSnapshot.hasData ||
                      !snapshot.hasError &&
                          snapshot.data != null &&
                          snapshot.data.data != null)
                  ? Scaffold(
                      appBar: AppBar(),
                      body: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data.data['name'].toString(),
                                style: TextStyle(
                                  fontSize: 40,
                                ),
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Text(
                                (snapshot.data.data['event_time'] != null)
                                    ? Jiffy(snapshot.data.data['event_time']
                                            .toDate())
                                        .yMMMMEEEEdjm
                                    : "no message",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                (snapshot.data.data['location'] != null)
                                    ? "Located at: " +
                                        snapshot.data.data['location']
                                    : "No Location specified.",
                                style: TextStyle(),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  (snapshot.data.data['description'] == null)
                                      ? "No Description given"
                                      : snapshot.data.data['description'],
                                  style: TextStyle(),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 40.0,
                                right: 40,
                                top: 8.0,
                                bottom: 8.0,
                              ),
                              child: ((responseSnapshot.data == null ||
                                      responseSnapshot.data.data == null))
                                  ? RaisedButton(
                                      autofocus: true,
                                      onPressed: () {
                                        setState(() {
                                          toggleRSVP(
                                            true,
                                            user.uid,
                                          );
                                        });
                                      },
                                      color: Colors.green,
                                      child: Text("RSVP"),
                                      onLongPress: () {
                                        setState(() {
                                          toggleRSVP(
                                            true,
                                            user.uid,
                                          );
                                        });
                                      },
                                    )
                                  : (responseSnapshot.data.data[user.uid] ==
                                              null ||
                                          responseSnapshot
                                                  .data.data[user.uid] ==
                                              'isNotComming')
                                      ? RaisedButton(
                                          autofocus: true,
                                          onPressed: () {
                                            setState(() {
                                              toggleRSVP(
                                                true,
                                                user.uid,
                                              );
                                            });
                                          },
                                          color: Colors.green,
                                          child: Text("RSVP"),
                                          onLongPress: () {
                                            setState(() {
                                              toggleRSVP(
                                                true,
                                                user.uid,
                                              );
                                            });
                                          },
                                        )
                                      : RaisedButton(
                                          autofocus: true,
                                          onPressed: () {
                                            setState(() {
                                              toggleRSVP(
                                                false,
                                                user.uid,
                                              );
                                            });
                                          },
                                          color: Colors.red,
                                          child: Text("Won't be able to come."),
                                          onLongPress: () {
                                            setState(() {
                                              toggleRSVP(
                                                false,
                                                user.uid,
                                              );
                                            });
                                          },
                                        ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Scaffold(
                      body: Loading(),
                      appBar: AppBar(),
                    );
            });
      },
    );
  }

  toggleRSVP(bool isComming, String uid) async {
    Map<String, dynamic> data = {
      uid: (isComming) ? 'isComming' : 'isNotComming',
    };

    await Firestore.instance
        .collection('events')
        .document(uuid)
        .collection('response')
        .document('rsvp')
        .setData(
          data,
          merge: true,
        );
  }
}
