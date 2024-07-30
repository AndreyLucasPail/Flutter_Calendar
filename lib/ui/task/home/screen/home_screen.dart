import 'package:flutter/material.dart';
import 'package:flutter_calendar/maneger/task_maneger.dart';
import 'package:flutter_calendar/utils/colors/custom_colors.dart';
import 'package:flutter_calendar/helper/db_helper.dart';
import 'package:flutter_calendar/ui/task/home/widget/calendar.dart';
import 'package:flutter_calendar/model/task_model.dart';
import 'package:provider/provider.dart';

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

    final taskManager = Provider.of<TaskManager>(context, listen: false);
    taskManager.getTaskForDateManeger(currentDate.day, currentDate.month);
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
        body: Consumer<TaskManager>(
          builder: (_, taskManager, __) {
            return SingleChildScrollView(
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
                    taskManager.taskForDateList.isNotEmpty
                        ? dayTask(taskManager)
                        : const Center(
                            child: Text(
                              "Nenhuma tarefa definida para o dia de hoje.",
                              style: TextStyle(
                                color: CustomColors.orange,
                                fontSize: 20,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  dayTask(TaskManager taskManager) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: taskManager.taskForDateList.map((task) {
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
}
