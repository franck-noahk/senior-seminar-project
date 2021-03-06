import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_bulletin/constants.dart';
import 'package:e_bulletin/models/user.dart';
import 'package:e_bulletin/widgets/layout/loading.dart';
import 'package:e_bulletin/widgets/pages/eventDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';

class UpcommingEventsList extends StatefulWidget {
  const UpcommingEventsList({
    Key key,
  }) : super(key: key);

  @override
  _UpcommingEventsListState createState() => _UpcommingEventsListState();
}

class _UpcommingEventsListState extends State<UpcommingEventsList> {
  @override
  Widget build(BuildContext context) {
    // return TestCards();
    DateTime now = new DateTime.now();
    DocumentSnapshot snapshot = Provider.of<DocumentSnapshot>(context);
    var user = Provider.of<User>(context);
    // now = "Timestamp(seconds=" + now + ",nanoseconds=0)";
    return StreamBuilder(
        stream: user.db.document,
        builder: (context, userSnapshot) {
          if (!userSnapshot.hasData) {
            return Loading();
          }
          if (userSnapshot.hasError) {
            print("We have Error");
            return Loading();
          }
          List<String> usersFollowing =
              List<String>.from(userSnapshot.data.data['isFollowing']);
          print("Users Following " + usersFollowing.toString());
          return StreamBuilder(
            key: saveMe,
            stream: Firestore.instance
                .collection('events')
                .where(
                  'event_time',
                  isGreaterThan: now,
                )
                .where('organizer', whereIn: usersFollowing)
                .orderBy("event_time", descending: false)
                .snapshots(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                int messageCount = snapshot.data.documents.length;
                if (messageCount == 0) {
                  return Center(
                    child: Text("No Upcomming Events"),
                  );
                } else {
                  return ListView.builder(
                      itemCount: messageCount,
                      itemBuilder: (_, int index) {
                        final DocumentSnapshot document =
                            snapshot.data.documents[index];
                        dynamic time = (document['event_time'].toDate());

                        final dynamic message = document['name'];
                        return Card(
                          elevation: 2.0,
                          child: ListTile(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                print("DocumentID being passed" +
                                    document.documentID);
                                return EventDetailPage(
                                  uuid: document.documentID,
                                );
                              }),
                            ),
                            title: Text(
                              message != null
                                  ? message.toString()
                                  : '<No message retrieved>',
                            ),
                            subtitle: Text(time != null
                                ? Jiffy(time).yMMMMEEEEdjm
                                : "no message"),
                          ),
                        );
                      });
                }
              } else {
                return Loading();
              }
            },
          );
        });
  }
}


