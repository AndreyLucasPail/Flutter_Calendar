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
  bool tasksLoaded = false;

  @override
  void initState() {
    super.initState();

    print("${currentDate.day} ---- ${currentDate.month}");
    if (!tasksLoaded) {
      loadTasksForDate(currentDate.day, currentDate.month);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => updateListTask(),
      child: Scaffold(
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
                  height: MediaQuery.of(context).size.height * 0.55,
                  width: MediaQuery.of(context).size.width,
                  child: const Calendar(),
                ),
                Row(
                  children: [
                    Container(
                      height: 1.5,
                      width: MediaQuery.of(context).size.width * 0.333,
                      color: Colors.grey[800],
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "Tarefas do Dia",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      height: 1.5,
                      width: MediaQuery.of(context).size.width * 0.333,
                      color: Colors.grey[800],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                tasks != []
                    ? dayTask()
                    : const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 36.0,
                          horizontal: 8.0,
                        ),
                        child: Center(
                          child: Text(
                            "Nenhuma tarefa definida para o dia de hoje.",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
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
          color: Colors.grey[900],
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "${task.task}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> loadTasksForDate(int day, int month) async {
    print("Antes de carregar tarefas");
    List<TaskModel> loadedTasks = await helper.getTaskForDate(day, month);
    print("tarefas carregadas: $loadedTasks");

    setState(() {
      tasks = loadedTasks;
      tasksLoaded = true;
    });
  }

  Future<void> updateListTask() async {
    setState(() {
      loadTasksForDate(currentDate.day, currentDate.month);
    });
  }
}
