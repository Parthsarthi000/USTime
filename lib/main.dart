import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'OpeningFirstTime/login_page.dart';
import 'home_page.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late bool isFirstTime;
  late DateTime loginDate;
  @override
  void initState() {
    super.initState();
    isUsersFirstTime();
  }

  Future<void> isUsersFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    if ((prefs.getBool("isFirstTime") ?? true) == true) {
      //if its users first time
      await prefs.setBool("isFirstTime",
          false); //set it to false to prevent future opens accesing the login screen
      loginDate = DateTime.now();
      await prefs.setString(
          "loginDate", DateFormat('yyyy-MM-dd').format(loginDate));
      isFirstTime = true;
    } else {
      isFirstTime = false; //not the first time
      loginDate = DateFormat('yyyy-MM-dd').parse(prefs.getString("loginDate")!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Broductivity',
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      // home: isFirstTime
      //     ? const FirstTimePage()
      //     : const MyHomePage(title: 'Flutter Demo Home Page'),
      home: const HomePage(),
    );
  }
}

//ToDo
//Create respective state widgets for both