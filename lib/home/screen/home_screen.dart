import 'package:flutter/material.dart';
import 'package:flutter_calendar/helper/db_helper.dart';
import 'package:flutter_calendar/home/widget/calendar.dart';
import 'package:flutter_calendar/model/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataBaseHelper helper = DataBaseHelper();
  List<TaskModel> tasks = [];
  DateTime currentDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    //loadTasksForDate(currentDate.day, currentDate.month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Calendario"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: const Calendar(),
              ),
              Divider(
                color: Colors.grey[800],
                thickness: 1.5,
              ),
              FutureBuilder<void>(
                future: loadTasksForDate(currentDate.day, currentDate.month),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return dayTask();
                  } else {
                    return const Center(
                      child: Text(
                        "Nenhuma tarefa para o dia de hoje!",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  dayTask() {
    print("TAREFAS: $tasks");
    return Column(
      children: tasks.map((task) {
        return Card(
          color: Colors.grey[800],
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "${task.task}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> loadTasksForDate(int day, int month) async {
    List<TaskModel> loadedTasks = await helper.getTaskForDate(day, month);
    setState(() {
      tasks = loadedTasks;
    });
  }
}
