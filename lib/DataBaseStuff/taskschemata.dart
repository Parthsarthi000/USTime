import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

enum Difficulty { easy, medium, hard }

enum Importance { low, medium, high }

enum RepeatType { noRepeat, daily, weekly }

enum Type { fixed, canShift }

enum Status { completed, toDo, missed, deleted }

abstract class TaskInterface {
  String get eventName;
  DateTime get from;
  DateTime get to;
  Color get background;
  bool get isAllDay;
  Difficulty get taskDifficulty;
  Type get taskType;
  Importance get taskImportance;
  Status get taskStatus;
  DateTime get deadline;
  RepeatType get repeatType;
}

class Task extends TaskInterface {
  @override
  String eventName;
  @override
  DateTime from;
  @override
  DateTime to;
  @override
  Color background;
  @override
  bool isAllDay;
  @override
  Difficulty taskDifficulty;
  @override
  Type taskType;
  @override
  Importance taskImportance;
  @override
  Status taskStatus;
  @override
  DateTime deadline;
  @override
  RepeatType repeatType;
  Task({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    required this.isAllDay,
    required this.taskDifficulty,
    required this.taskType,
    required this.taskImportance,
    required this.taskStatus,
    required this.deadline,
    required this.repeatType,
  });
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Task> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

Future<List<Task>> getTasks() async {
  final List<Task> tasks = <Task>[];
  return tasks;
}

// List<Task> addTask(List<Task> tasks) {
//   tasks.add();
//   return tasks;
// }
