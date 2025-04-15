import 'package:flutter/material.dart';

class FirstTimePage extends StatefulWidget {
  const FirstTimePage({super.key});
  @override
  State<FirstTimePage> createState() => FirstTimePageState();
}

class FirstTimePageState extends State<FirstTimePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Welcome to BroDuctivity"),
          Text("Your personalised Self-Improvement Buddy :)")
        ],
      ),
    ));
  }
}
