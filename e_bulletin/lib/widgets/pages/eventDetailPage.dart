import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class EventDetailPage extends StatefulWidget {
  EventDetailPage({
    Key key,
    DocumentSnapshot data,
  }) : super(key: key);

  @override
  _EventPageDetailState createState() => _EventPageDetailState(data);
}

class _EventPageDetailState extends State<EventDetailPage> {
  _EventPageDetailState(this.data);
  DocumentSnapshot data;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(data['name']),
          Text(
            (data['event_time'].toDate() != null)
                ? Jiffy(data['event_time'].toDate()).yMMMMEEEEdjm
                : "no message",
          ),
          Text(
            (data['location'].toString() != null)
                ? data['location']
                : "No Location specified.",
          ),
          Text(
            (data['description'] == null)
                ? "No Description given"
                : data['description'],
          ),
          RaisedButton(onPressed: toggleRSVP()),
        ],
      ),
    );
  }
}

toggleRSVP() {}
