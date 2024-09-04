import 'package:flutter/material.dart';
import 'package:flutter_calendar/maneger/task_maneger.dart';
import 'package:flutter_calendar/utils/colors/custom_colors.dart';
import 'package:flutter_calendar/helper/db_helper.dart';
import 'package:flutter_calendar/model/task_model.dart';
import 'package:flutter_calendar/ui/task/widgets/task_tile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, this.day, this.month});

  final int? day;
  final int? month;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  DataBaseHelper helper = DataBaseHelper();
  List<TaskModel> tasks = [];

  final TextEditingController taskController = TextEditingController();

  final String? date = DateFormat("dd/MM/yy - HH:mm").format(DateTime.now());

  @override
  void initState() {
    super.initState();

    final taskManager = Provider.of<TaskManager>(context, listen: false);

    taskManager.getTaskForDateManeger(widget.day!, widget.month!);

    helper.initDb();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: CustomColors.white,
            ),
          ),
          elevation: 0,
          backgroundColor: CustomColors.backgroundColor,
          title: const Text(
            "Tarefas do dia",
            style: TextStyle(
              color: CustomColors.white,
              fontSize: 24,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
        ),
        floatingActionButton: newTaskbutton(),
        body: Consumer<TaskManager>(
          builder: (_, taskManeger, __) {
            return ListView.builder(
              itemCount: taskManeger.taskForDateList.length,
              itemBuilder: (context, index) {
                return taskCard(taskManeger.taskForDateList[index]);
              },
            );
          },
        ),
      ),
    );
  }

  Widget taskCard(TaskModel task) {
    return Dismissible(
      confirmDismiss: (direction) => dialog(context, task),
      key: UniqueKey(),
      child: TaskTile(
        listTask: task,
      ),
    );
  }

  newTaskbutton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: CustomColors.backgroundColor,
          context: context,
          builder: (context) {
            return Card(
              color: CustomColors.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 24.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Adicionar uma nova Tarefa",
                      style: TextStyle(
                        color: CustomColors.white,
                        fontSize: 24,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 100),
                    TextFormField(
                      controller: taskController,
                      style: const TextStyle(
                        color: CustomColors.white,
                        fontSize: 18,
                      ),
                      decoration: const InputDecoration(
                        hoverColor: CustomColors.white,
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(
                          color: CustomColors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 55,
                      width: 300,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.orange,
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          TaskModel newTask = TaskModel(
                            task: taskController.text,
                            date: date,
                            day: widget.day,
                            month: widget.month,
                          );

                          context.read<TaskManager>().addTaskManeger(newTask);
                          context.read<TaskManager>().getTaskForDateManeger(
                                widget.day!,
                                widget.month!,
                              );

                          taskController.clear();

                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Salvar tarefa",
                          style: TextStyle(
                            fontSize: 18,
                            color: CustomColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      backgroundColor: CustomColors.orange,
      child: const Icon(
        Icons.add,
        size: 30,
      ),
    );
  }

  Future<bool?> dialog(BuildContext context, TaskModel task) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: CustomColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: const Text(
            "Remover Tarefa",
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 24,
              letterSpacing: 1,
            ),
          ),
          content: const Text(
            "Certeza que deseja remover esta Terefa?",
            style: TextStyle(
              color: CustomColors.black,
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancelar",
                style: TextStyle(
                  color: CustomColors.red,
                  fontSize: 20,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<TaskManager>().deleteTaskManeger(task.id!);
                context.read<TaskManager>().getTaskForDateManeger(
                      widget.day!,
                      widget.month!,
                    );

                Navigator.pop(context);
              },
              child: const Text(
                "Confirmar",
                style: TextStyle(
                  color: CustomColors.blue,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
