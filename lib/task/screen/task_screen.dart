import 'package:flutter/material.dart';
import 'package:flutter_calendar/helper/db_helper.dart';
import 'package:flutter_calendar/model/task_model.dart';
import 'package:flutter_calendar/task/tile/task_tile.dart';
import 'package:flutter_calendar/task/widgets/new_task_button.dart';

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

  @override
  void initState() {
    super.initState();

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
      floatingActionButton: NewTaskButton(
        day: widget.day,
        month: widget.month,
      ),
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
}
