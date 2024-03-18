import 'package:flutter/material.dart';
import 'package:flutter_calendar/core/custom_colors.dart';
import 'package:flutter_calendar/model/task_model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    this.listTask,
  });

  final TaskModel? listTask;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card(
        color: CustomColors.orange,
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
                  color: CustomColors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${listTask!.task}',
                style: const TextStyle(
                  color: CustomColors.white,
                  fontSize: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
