import 'package:flutter/material.dart';

class UpcommingEventsList extends StatelessWidget {
  const UpcommingEventsList({
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
    ));
  }
}
