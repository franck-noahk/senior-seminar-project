import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:e_bulletin/constants.dart';

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

    return StreamBuilder(
      stream: Firestore.instance
          .collection('events')
          .orderBy(
            'event_time',
            descending: true,
          )
          .snapshots(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData && snapshot.connectionState.index == 2)
          return Center(child: Text('Loading...'));
        if (!snapshot.hasData && snapshot.connectionState.index == 3)
          return Center(child: Text('No Events:'));
        if (snapshot.hasData) {
          final int messageCount = snapshot.data.documents.length;
          return ListView.builder(
              itemCount: messageCount,
              itemBuilder: (_, int index) {
                final DocumentSnapshot document =
                    snapshot.data.documents[index];
                final time = document['time'];
                final dynamic message = document['name'];
                return Card(
                  elevation: 2.0,
                  child: ListTile(
                    title: Text(
                      message != null
                          ? message.toString()
                          : '<No message retrieved>',
                    ),
                    subtitle:
                        Text(time != null ? time.toString() : "no message"),
                  ),
                );
              });
        } else {
          return Text("Error");
        }
      },
    );
  }
}

class TestCards extends StatelessWidget {
  const TestCards({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text("CARD OF FUN"),
              subtitle: Text("Dates are also fun"),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("CARD OF FUN"),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("CARD OF FUN"),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("CARD OF FUN"),
            ),
          ),
          Card(
            child: ListTile(
              title: Text("CARD OF FUN"),
            ),
          ),
        ],
      ),
    );
  }
}
