import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:time_manager/DataBaseStuff/taskschemata.dart';
import 'package:path/path.dart';

class DatabaseTask extends TaskInterface {
  @override
  int dayNumber;
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
  DatabaseTask({
    required this.dayNumber,
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

  factory DatabaseTask.fromMap(Map<String, dynamic> map) {
    return DatabaseTask(
      dayNumber: map["dayNumber"] as int,
      eventName: map["eventName"] as String,
      from: DateTime.parse(
          map["startTime"] as String), // Convert stored String to DateTime
      to: DateTime.parse(map["endTime"] as String),
      background:
          Color(map["background"] as int), // Convert stored int to Color
      isAllDay: (map["isAllDay"] as int) == 1,
      taskDifficulty: Difficulty.values.byName(
          map["taskDifficulty"] as String), // Convert stored String to Enum
      taskType: Type.values.byName(map["taskType"] as String),
      taskImportance: Importance.values.byName(map["taskImportance"] as String),
      taskStatus: Status.values.byName(map["taskStatus"] as String),
      deadline: DateTime.parse(map["deadline"] as String),
      repeatType: RepeatType.values.byName(map["repeatType"] as String),
    );
  }
  factory DatabaseTask.fromTask(Task task) {
    return DatabaseTask(
      eventName: task.eventName,
      dayNumber: task.dayNumber,
      from: task.from,
      to: task.to,
      background: task.background,
      isAllDay: task.isAllDay,
      taskDifficulty: task.taskDifficulty,
      taskType: task.taskType,
      taskImportance: task.taskImportance,
      taskStatus: task.taskStatus,
      deadline: task.deadline,
      repeatType: task.repeatType,
    );
  }

  Task toTask() {
    return Task(
        dayNumber: dayNumber,
        eventName: eventName,
        from: from,
        to: to,
        background: background,
        isAllDay: isAllDay,
        taskDifficulty: taskDifficulty,
        taskType: taskType,
        taskImportance: taskImportance,
        taskStatus: taskStatus,
        deadline: deadline,
        repeatType: repeatType);
  }

  Map<String, dynamic> toMap() {
    return {
      "eventName": eventName,
      "dayNumber": dayNumber,
      "startTime": from.toIso8601String(),
      "endTime": to.toIso8601String(),
      "background": background.value,
      "isAllDay": isAllDay ? 1 : 0,
      "taskDifficulty": taskDifficulty.name,
      "taskType": taskType.name,
      "taskImportance": taskImportance.name,
      "taskStatus": taskStatus.name,
      "deadline": deadline.toIso8601String(),
      "repeatType": repeatType.name,
    };
  }
}

class DatabaseService {
  static final DatabaseService instance = DatabaseService._constructor();
  DatabaseService._constructor();
  static Database? db;
  final String tasksTable = "Tasks";
  Future<Database> get database async {
    if (db != null) return db!;
    db = await getDatabase();
    return db!; //!is null assertion operator tells compiler the variable is not null so stop yapping
  }

  Future<Database> getDatabase() async {
    final databaseDirectory = await getDatabasesPath();
    final databasePath = join(databaseDirectory, "ToDo.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $tasksTable(
          eventName TEXT NOT NULL,
          dayNumber INTEGER NOT NULL,
          startTime TEXT NOT NULL,
          endTime TEXT NOT NULL,
          background INTEGER NOT NULL,
          isAllDay INTEGER NOT NULL,
          taskDifficulty TEXT NOT NULL,
          taskType TEXT NOT NULL,
          taskImportance TEXT NOT NULL,
          taskStatus TEXT NOT NULL,
          deadline TEXT NOT NULL,
          repeatType TEXT NOT NULL,
          PRIMARY KEY (eventName, dayNumber, startTime)
        );
      ''');
      },
    );
    return database;
  }

  Future<List<Task>> fetchMyTasksOnAppStart() async {
    final db = await database;
    List<Map<String, Object?>> tasksMap =
        await db.rawQuery('SELECT * FROM $tasksTable');
    if (tasksMap.isEmpty) return [];
    final List<Task> tasks = [];
    for (var task in tasksMap) {
      tasks.add(DatabaseTask.fromMap(task).toTask());
    }
    return tasks;
  }

  Future<void> addTaskTodatabase(Task task) async {
    final db = await database;
    // DatabaseTask dbTask = DatabaseTask.fromTask(task);
    await db.insert(tasksTable, DatabaseTask.fromTask(task).toMap());
    return;
  }
}
