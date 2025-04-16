import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

enum Difficulty { easy, medium, hard }

enum Importance { low, medium, high }

enum Type { fixed, canShift }

enum Status { completed, toDo, missed }

class Task {
  Task(
      this.eventName,
      this.from,
      this.to,
      this.background,
      this.isAllDay,
      this.taskDifficulty,
      this.taskType,
      this.deadline,
      this.taskImportance,
      this.taskStatus);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  Difficulty taskDifficulty;
  Type taskType;
  Importance taskImportance;
  Status taskStatus;
  DateTime deadline;
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

List<Task> getTasks() {
  final List<Task> tasks = <Task>[];
  return tasks;
}
