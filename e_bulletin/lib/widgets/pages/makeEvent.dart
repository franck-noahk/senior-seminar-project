import 'package:flutter/material.dart';

class MakeEvent extends StatefulWidget {
  MakeEvent({Key key}) : super(key: key);

  @override
  _MakeEventState createState() => _MakeEventState();
}

class _MakeEventState extends State<MakeEvent> {
  String title;
  String location;
  String description;
  DateTime date;
  TimeOfDay time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new Event"),
      ),
      body: Center(
        child: Form(
          child: Container(
            margin: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Title of Event",
                  ),
                ), //Title
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Location of the event",
                  ),
                ), //Location
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Short Description of the event",
                    ),
                    expands: true,
                    maxLines: null,
                    minLines: null,
                  ),
                ), //description
                RaisedButton(
                  onPressed: () async {
                    date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: datePlusOneYear(),
                    );
                    time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                  },
                  child: Container(
                    child: Text("Pick A Date and Time"),
                  ),
                ),
                RaisedButton(
                  onPressed: submitEvent(
                    title,
                    location,
                    description,
                    date,
                    time,
                  ),
                  child: Text("Submit Event"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

submitEvent(
  String title,
  String location,
  String description,
  DateTime date,
  TimeOfDay time,
) {}

DateTime datePlusOneYear() {
  String dateString = DateTime.now().toString();
  print("Date String = " + dateString);
  return DateTime.now();
}
