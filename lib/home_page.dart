import 'package:flutter/material.dart';
import 'add_task_page.dart';
import 'drawer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'DataBaseStuff/taskschemata.dart';
import 'DataBaseStuff/crud_ops.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late bool homePage;
  final CalendarController _calendarController = CalendarController();

  List<Task> tasks = [];
  // final DatabaseService databaseService = DatabaseService.instance;
  CalendarDataSource? tasksData;
  //getTasks function initialises the appointments variable in the class MeetingDataSource extends CalendarDataSource. Data from database needs to be fetched from getTasks()and updated acordingly
  @override
  void initState() {
    super.initState();
    homePage = true;
    _calendarController.view = CalendarView.day;
    fetchTasks();
  }

  void switchToCalendar() {
    setState(() {
      homePage = false;
    });
  }

  void fetchTasks() async {
    // tasks = await getTasks();
    setState(() {
      // tasksData = MeetingDataSource(tasks);
    });
  }

  void showDeleteDialogue() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog();
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
            tooltip: "Week",
            onPressed: () {
              _calendarController.view = CalendarView.week;
              switchToCalendar();
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_view_day_rounded),
            tooltip: "Day",
            onPressed: () {
              _calendarController.view = CalendarView.day;
              switchToCalendar();
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_view_month_rounded),
            tooltip: "Month",
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
              showWeekNumber: true,
              dataSource: tasksData,
              showNavigationArrow: true,
              showCurrentTimeIndicator: false,
              allowAppointmentResize: true,
              onAppointmentResizeEnd: (AppointmentResizeEndDetails details) {
                setState(() {
                  print(
                      "Resize Event Triggered! New Start: ${details.startTime}, New End: ${details.endTime}");
                  Task updatedTask = details.appointment as Task;
                  updatedTask.from = details.startTime!;
                  updatedTask.to = details.endTime!;
                  tasksData =
                      MeetingDataSource(tasks); // Refresh calendar data source
                });
              },
              // initialSelectedDate: DateTime.now(),
              todayHighlightColor: Colors.red,
              onLongPress: (CalendarLongPressDetails details) async {
                if (details.targetElement == CalendarElement.calendarCell) {
                  if (details.appointments != null) {
                    showDeleteDialogue();
                  } else {
                    final newTask = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddTaskPage(date: details.date ?? DateTime.now()),
                      ),
                    );

                    if (newTask != null && newTask is Task) {
                      setState(() {
                        tasks.add(newTask);
                        tasksData = MeetingDataSource(tasks);
                      });
                    }
                  }
                }
              }),
    );
  }
}
