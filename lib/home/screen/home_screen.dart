import 'package:flutter/material.dart';
import 'package:flutter_calendar/core/custom_colors.dart';
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

    setState(() {
      loadTasksForDate(currentDate.day, currentDate.month);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.backgroundColor,
          title: const Text(
            "Calendario",
            style: TextStyle(
              color: CustomColors.white,
              fontSize: 24,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.48,
                  width: MediaQuery.of(context).size.width,
                  child: const Calendar(),
                ),
                Row(
                  children: [
                    Container(
                      height: 1.5,
                      width: MediaQuery.of(context).size.width * 0.307,
                      color: CustomColors.white,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      "Tarefas do Dia",
                      style: TextStyle(
                        color: CustomColors.white,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      height: 1.5,
                      width: MediaQuery.of(context).size.width * 0.307,
                      color: CustomColors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                tasks == []
                    ? const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 36.0,
                          horizontal: 8.0,
                        ),
                        child: Center(
                          child: Text(
                            "Nenhuma tarefa definida para o dia de hoje.",
                            style: TextStyle(
                              color: CustomColors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      )
                    : dayTask()
              ],
            ),
          ),
        ),
      ),
    );
  }

  dayTask() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: tasks.map((task) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            color: CustomColors.orange,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "${task.task}",
                style: const TextStyle(
                  color: CustomColors.white,
                  fontSize: 24,
                ),
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
      tasksLoaded = true;
    });
  }
}
