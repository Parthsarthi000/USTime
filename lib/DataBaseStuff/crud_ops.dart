import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:time_manager/DataBaseStuff/taskschemata.dart';
import 'package:path/path.dart';

class DatabaseTask extends TaskInterface {
  DatabaseTask({
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
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          eventName TEXT NOT NULL,
          from TEXT NOT NULL,
          to TEXT NOT NULL,
          background INTEGER NOT NULL,
          isAllDay INTEGER NOT NULL,
          taskDifficulty TEXT NOT NULL,
          taskType TEXT NOT NULL,
          taskImportance TEXT NOT NULL,
          taskStatus TEXT NOT NULL,
          deadline TEXT NOT NULL,
          repeatType TEXT NOT NULL
        );
      ''');
      },
    );
    return database;
  }
}
