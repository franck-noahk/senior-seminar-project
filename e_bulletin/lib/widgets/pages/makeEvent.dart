import 'package:e_bulletin/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Event"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
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
                  onChanged: (value) => title = value,
                  validator: (value) =>
                      (value == null) ? "Please Enter a valid title" : null,
                ), //Title
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Location of the event",
                  ),
                  onChanged: (value) => location = value,
                ), //Location
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "Short Description of the event",
                    ),
                    onChanged: (value) => description = value,
                    expands: true,
                    maxLines: null,
                    minLines: null,
                    validator: (value) => (value == null)
                        ? "Please enter some description"
                        : null,
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
                  onPressed: () {
                    if (_formKey.currentState.validate())
                      submitEvent(
                        title,
                        location,
                        description,
                        date,
                        time,
                        user,
                      );
                    Navigator.pop(context);
                  },
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
  var user,
) async {
  Map<String, dynamic> eventSheet = new Map();
  DateTime newTime = DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
  eventSheet.addAll({
    'name': title,
    'location': location,
    'description': description,
    'event_time': newTime,
  });
  await user.db.createEvent(eventSheet);
}

DateTime datePlusOneYear() {
  String dateString = DateTime.now().toString();
  print("Date String = " + dateString);
  return DateTime.now().add(
    Duration(days: 365),
  );
}
