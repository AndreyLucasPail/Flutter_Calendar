import 'package:flutter/material.dart';
import 'package:flutter_calendar/model/task_model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, this.listTask});

  final TaskModel? listTask;

  @override
  Widget build(BuildContext context) {

    print(listTask!.day);

    return ListTile(
      title: Text(
        '${listTask!.task}',
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}