import 'package:flutter/material.dart';
import 'package:flutter_calendar/helper/db_helper.dart';
import 'package:flutter_calendar/model/task_model.dart';
import 'package:flutter_calendar/task/tile/task_tile.dart';
import 'package:flutter_calendar/task/widgets/new_task_button.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  DataBaseHelper helper = DataBaseHelper();

  @override
  void initState() {
    super.initState();

    helper.getAllTasks();
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
      body: FutureBuilder<List<TaskModel>>(
        future: helper.getAllTasks(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting || !snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            );
          }else{
            return ListView.builder(
              itemBuilder: (context, index){
                List<TaskModel>? task = snapshot.data;
                return TaskTile(listTask: task![index],);
              }
            );
          }
        }
      ),
      floatingActionButton: const NewTaskButton(),
    );
  }
}