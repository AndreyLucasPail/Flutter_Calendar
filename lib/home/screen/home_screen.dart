import 'package:flutter/material.dart';
import 'package:flutter_calendar/home/widget/calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Calendario"),
        centerTitle: true,
      ),
      body: const Calendar(),
    );
  }
}