import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // CalendarView calendarView = CalendarView.day;
  final CalendarController _calendarController = CalendarController();
  @override
  void initState() {
    super.initState();
    _calendarController.view = CalendarView.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text("USTime"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_view_week_rounded),
            tooltip: "Add a Task",
            onPressed: () {
              _calendarController.view = CalendarView.week;
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_view_day_rounded),
            tooltip: "Add a Task",
            onPressed: () {
              _calendarController.view = CalendarView.day;
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_view_month_rounded),
            tooltip: "Add a Task",
            onPressed: () {
              _calendarController.view = CalendarView.month;
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: SfCalendar(
        controller: _calendarController,
        // showWeekNumber: true,
        // firstDayOfWeek: 1,
        // initialSelectedDate: DateTime.now(),
        todayHighlightColor: Colors.red,
      ),
    );
  }
}
