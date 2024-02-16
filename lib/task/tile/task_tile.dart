import 'package:flutter/material.dart';
import 'package:flutter_calendar/model/task_model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, this.listTask});

  final TaskModel? listTask;

  @override
  Widget build(BuildContext context) {

    print(listTask!.day);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${listTask!.date}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${listTask!.task}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}