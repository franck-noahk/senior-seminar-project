import 'package:flutter/material.dart';

class MakeEvent extends StatefulWidget {
  MakeEvent({Key key}) : super(key: key);

  @override
  _MakeEventState createState() => _MakeEventState();
}

class _MakeEventState extends State<MakeEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
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
