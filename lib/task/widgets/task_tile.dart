import 'package:flutter/material.dart';
import 'package:flutter_calendar/helper/db_helper.dart';
import 'package:flutter_calendar/model/task_model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    this.listTask,
  });

  final TaskModel? listTask;

  @override
  Widget build(BuildContext context) {
    final DataBaseHelper helper = DataBaseHelper();

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Dismissible(
        key: UniqueKey(),
        onDismissed: (direction) {
          helper.deleteTask(listTask!.id!);
        },
        child: Card(
          color: Colors.grey[900],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${listTask!.date}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${listTask!.task}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
