import 'package:flutter/material.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      drawer: AppDrawer(),
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
