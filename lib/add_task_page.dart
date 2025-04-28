import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'DataBaseStuff/taskschemata.dart';
import 'package:date_time_picker/date_time_picker.dart';

class AddTaskPage extends StatefulWidget {
  final DateTime date;
  const AddTaskPage({super.key, required this.date});
  @override
  State<AddTaskPage> createState() => AddTaskPageState();
}

class AddTaskPageState extends State<AddTaskPage> {
  late DateTime date;
  @override
  void initState() {
    super.initState();
    date = widget.date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Task"),
          centerTitle: true,
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              TextField(
                  decoration: InputDecoration(
                labelText: "Task Name",
                border: OutlineInputBorder(),
              )),
              // CalendarDatePicker(
              //   initialDate: date,
              //   firstDate: DateTime(2000),
              //   lastDate: DateTime(2100),
              //   onDateChanged: (newDate) {
              //     setState(() => date = newDate);
              //   },
              // ),
              DateTimePicker(
                initialValue: date.toIso8601String(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onChanged: (val) => date = DateTime.parse(val),
                decoration: InputDecoration(
                  labelText: "Select Date & Time",
                  // border: OutlineInputBorder(),
                ),
              ),
            ])));
  }
}
