import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  late DateTime startTime;
  late DateTime deadline;
  late DateTime endTime;
  late bool isAllDay;
  double difficulty = 1;
  double importance = 1;
  int type = 0;
  int repeatType = 0;
  @override
  void initState() {
    super.initState();
    startTime = widget.date;
    endTime = startTime.add(const Duration(hours: 1));
    deadline = endTime;
    isAllDay = false;
  }

  Difficulty get selectedDifficulty {
    return Difficulty.values[difficulty.toInt()];
  }

  Importance get selectedImportance {
    return Importance.values[importance.toInt()];
  }

  Type get selectedType {
    return Type.values[type];
  }

  RepeatType get selectedRepeatType {
    return RepeatType.values[repeatType];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Task"),
          centerTitle: true,
          actions: [TextButton(onPressed: () {}, child: Text("Save"))],
        ),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const TextField(
                      decoration: InputDecoration(
                    labelText: "Task Name",
                    border: OutlineInputBorder(),
                  )),
                  DateTimePicker(
                    type: DateTimePickerType
                        .dateTime, // ✅ Enables both date & time
                    initialValue: startTime.toIso8601String(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onChanged: (val) => startTime = DateTime.parse(val),
                    onSaved: (val) => startTime = DateTime.parse(val!),
                    decoration: const InputDecoration(
                      labelText: "Task Start",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  DateTimePicker(
                    type: DateTimePickerType.dateTime,
                    initialValue: endTime.toIso8601String(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onChanged: (val) => endTime = DateTime.parse(val),
                    onSaved: (val) => endTime = DateTime.parse(val!),
                    decoration: const InputDecoration(
                      labelText: "Task End",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Row(
                    children: [
                      const Text("Mark activity for entire day?"),
                      Checkbox(
                        value: isAllDay,
                        onChanged: (bool? value) {
                          setState(() {
                            isAllDay = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Slider(
                        value: difficulty,
                        min: 0,
                        max: 2,
                        divisions:
                            2, // Ensures 3 fixed steps (1=Easy, 2=Medium, 3=Hard)
                        onChanged: (value) {
                          setState(() => difficulty = value);
                        },
                      ),
                      const SizedBox(height: 10),
                      Text("Difficulty: ${selectedDifficulty.name}",
                          style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                  Column(
                    children: [
                      Slider(
                        value: importance,
                        min: 0,
                        max: 2,
                        divisions:
                            2, // Ensures 3 fixed steps (1=Easy, 2=Medium, 3=Hard)
                        onChanged: (value) {
                          setState(() => importance = value);
                        },
                      ),
                      const SizedBox(height: 10),
                      Text("Importance: ${selectedImportance.name}",
                          style: const TextStyle(fontSize: 18)),
                    ],
                  ),
                  Column(children: [
                    const Text(
                        "Can this task be reassigned to another time slot?"),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    type == 0 ? Colors.blue[700] : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  type = 0;
                                });
                              },
                              child: const Text("Fixed")),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    type == 1 ? Colors.blue[700] : null,
                              ),
                              onPressed: () {
                                setState(() {
                                  type = 1;
                                });
                              },
                              child: const Text("Shiftable"))
                        ]),
                  ]),
                  Column(
                    children: [
                      const Text("When should this task repeat?"),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      repeatType == 0 ? Colors.blue[700] : null,
                                ),
                                onPressed: () {
                                  setState(() {
                                    repeatType = 0;
                                  });
                                },
                                child: const Text("No Repeat")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      repeatType == 1 ? Colors.blue[700] : null,
                                ),
                                onPressed: () {
                                  setState(() {
                                    repeatType = 1;
                                  });
                                },
                                child: const Text("Daily")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      repeatType == 2 ? Colors.blue[700] : null,
                                ),
                                onPressed: () {
                                  setState(() {
                                    repeatType = 2;
                                  });
                                },
                                child: const Text("Weekly")),
                          ]),
                    ],
                  ),
                  DateTimePicker(
                    type: DateTimePickerType
                        .dateTime, // ✅ Enables both date & time
                    initialValue: deadline.toIso8601String(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    onChanged: (val) => deadline = DateTime.parse(val),
                    onSaved: (val) => deadline = DateTime.parse(val!),
                    decoration: const InputDecoration(
                      labelText: "Deadline for the task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ])));
  }
}
