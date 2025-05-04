import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  late DateTime loginDate;
  final CalendarController _calendarController = CalendarController();
  List<Task> tasks = [];
  List<Task> currentDayTasks = [];
  late DateTime currentDay;
  final DatabaseService databaseService = DatabaseService.instance;
  CalendarDataSource? tasksData;
  //getTasks function initialises the appointments variable in the class MeetingDataSource extends CalendarDataSource. Data from database needs to be fetched from getTasks()and updated acordingly
  @override
  void initState() {
    super.initState();
    homePage = true;
    _calendarController.view = CalendarView.day;
    fetchTasks();
    ftechLoginDate();
  }

  Future<void> ftechLoginDate() async {
    final prefs = await SharedPreferences.getInstance();
    loginDate = DateFormat('yyyy-MM-dd').parse(prefs.getString("loginDate")!);
  }

  void switchToCalendar() {
    setState(() {
      homePage = false;
    });
  }

  void fetchTasks() async {
    tasks = await databaseService.fetchMyTasksOnAppStart();
    print(tasks.length);
    setState(() {
      tasksData = MeetingDataSource(tasks);
    });
  }

  void showDeleteDialogue(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // ✅ Aligns items correctly
          children: [
            const Text("Refactor Task"), // ✅ Task title
            IconButton(
              onPressed: () => Navigator.pop(context), // ✅ Close dialog
              icon: const Icon(
                Icons.cancel_outlined,
              ), // ✅ Styled cross icon
            ),
          ],
        ),
        content: Text("Are you sure you want to Refactor '${task.eventName}'?"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Reassign"),
          ),
          TextButton(
            onPressed: () {
              deleteTask(task); // ✅ Call deletion function
              Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }

  void deleteTask(Task task) {
    setState(() {
      tasks.remove(task); // ✅ Remove from local list
      tasksData = MeetingDataSource(tasks); // ✅ Refresh data source
    });

    databaseService.deleteTaskFromDatabase(task); // ✅ Remove from database
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
            ? Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //     colors: [
                //       Colors.blue.shade400,
                //       Colors.blue.shade900
                //     ], // ✅ Background gradient
                //     begin: Alignment.topLeft,
                //     end: Alignment.bottomRight,
                //   ),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_back_outlined)),
                          const SizedBox(
                            width: 30,
                          ),
                          Card(
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: RichText(
                                text: const TextSpan(
                                  text: "Today is: ", // ✅ Default text
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  children: [
                                    TextSpan(
                                      text: "Stressful", // ✅ Highlighted part
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.arrow_forward_outlined)),
                        ],
                      ),
                    ),

                    SizedBox(height: 30), // ✅ Spacing
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: ListView.builder(
                        itemCount: tasks.length, // ✅ Display tasks dynamically
                        itemBuilder: (context, index) {
                          Task task = tasks[index];
                          return Card(
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              title: Text(task.eventName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                              subtitle: Text(
                                  "Due: ${task.from.toLocal().toString().split(' ')[0]}"),
                              // trailing: Icon(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : SfCalendar(
                controller: _calendarController,
                showWeekNumber: true,
                dataSource: tasksData,
                showNavigationArrow: true,
                showCurrentTimeIndicator: false,
                firstDayOfWeek: 1,

                // initialSelectedDate: DateTime.now(),
                todayHighlightColor: Colors.red,
                onLongPress: (CalendarLongPressDetails details) async {
                  if (details.targetElement == CalendarElement.appointment) {
                    // ✅ Fix: Handle long press on appointment blocks
                    if (details.appointments != null &&
                        details.appointments!.isNotEmpty) {
                      final selectedTask = details.appointments!.first as Task;
                      showDeleteDialogue(
                          selectedTask); // ✅ Open delete confirmation dialog
                    }
                  } else if (details.targetElement ==
                      CalendarElement.calendarCell) {
                    // ✅ Handle long press on empty cells

                    final newTask = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddTaskPage(date: details.date ?? DateTime.now()),
                      ),
                    );

                    if (newTask != null && newTask is Task) {
                      DateTime today = DateTime.now();
                      Duration difference = today.difference(loginDate);
                      int dayNumber = difference.inDays;
                      newTask.dayNumber = dayNumber;

                      setState(() {
                        tasks.add(newTask);
                        tasksData = MeetingDataSource(tasks);
                      });

                      databaseService.addTaskTodatabase(newTask);
                    }
                  }
                }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: "Generate a Schedule for the week",
          child: const Icon(Icons.generating_tokens),
        ));
  }
}
