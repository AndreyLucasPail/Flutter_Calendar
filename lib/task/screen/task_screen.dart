import 'package:flutter/material.dart';
import 'package:flutter_calendar/helper/db_helper.dart';
import 'package:flutter_calendar/model/task_model.dart';
import 'package:flutter_calendar/task/widgets/task_tile.dart';
import 'package:intl/intl.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, this.day, this.month});

  final int? day;
  final int? month;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  DataBaseHelper helper = DataBaseHelper();
  List<TaskModel> tasks = [];

  final TextEditingController taskController = TextEditingController();

  final String? date = DateFormat("dd/MM/yy - HH:mm").format(DateTime.now());

  @override
  void initState() {
    super.initState();

    helper.initDb();

    loadTasksForDate(widget.day!, widget.month!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Tarefas do dia"),
        centerTitle: true,
      ),
      floatingActionButton: newTaskbutton(),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return TaskTile(
              listTask: tasks[index],
            );
          }),
    );
  }

  Future<void> loadTasksForDate(int day, int month) async {
    List<TaskModel> loadedTasks = await helper.getTaskForDate(day, month);
    setState(() {
      tasks = loadedTasks;
    });
  }

  newTaskbutton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            backgroundColor: Colors.black,
            context: context,
            builder: (context) {
              return Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: taskController,
                          decoration: const InputDecoration(
                            labelText: "Nova Tarefa",
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 55,
                          width: 300,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: const StadiumBorder()),
                            onPressed: () {
                              TaskModel newTask = TaskModel(
                                task: taskController.text,
                                date: date,
                                day: widget.day,
                                month: widget.month,
                              );

                              setState(() {
                                helper.addTask(newTask);
                                loadTasksForDate(widget.day!, widget.month!);
                              });

                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Salvar tarefa",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        IconButton(
                          onPressed: () {
                            helper.deleteDB();
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      backgroundColor: Colors.orange,
      child: const Icon(
        Icons.add,
        size: 30,
      ),
    );
  }
}
