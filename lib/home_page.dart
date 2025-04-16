import 'package:flutter/material.dart';
import 'drawer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'DataBase Stuff/taskschemata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late bool homePage;
  final CalendarController _calendarController = CalendarController();
  @override
  void initState() {
    super.initState();
    homePage = true;
    _calendarController.view = CalendarView.day;
  }

  void switchToCalendar() {
    setState(() {
      homePage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GestureDetector(
          onTap: () {
            setState(() {
              homePage = true;
            });
          },
          child: const Text("USTime"),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.calendar_view_week_rounded),
            tooltip: "Add a Task",
            onPressed: () {
              _calendarController.view = CalendarView.week;
              switchToCalendar();
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_view_day_rounded),
            tooltip: "Add a Task",
            onPressed: () {
              _calendarController.view = CalendarView.day;
              switchToCalendar();
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_view_month_rounded),
            tooltip: "Add a Task",
            onPressed: () {
              _calendarController.view = CalendarView.month;
              switchToCalendar();
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: homePage
          ? Container()
          : SfCalendar(
              controller: _calendarController,
              dataSource: MeetingDataSource(getTasks()),
              showNavigationArrow: true,
              showCurrentTimeIndicator: false,
              // initialSelectedDate: DateTime.now(),
              todayHighlightColor: Colors.red,
            ),
    );
  }
}
