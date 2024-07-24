import 'package:flutter/material.dart';
import 'package:flutter_calendar/helper/db_helper.dart';
import 'package:flutter_calendar/model/task_model.dart';

class TaskManager extends ChangeNotifier {
  final DataBaseHelper _dataBaseHelper = DataBaseHelper();

  List<TaskModel> taskForDateList = [];
  TaskModel? task;
  List<TaskModel> allTasksList = [];

  Future<void> getTask() async {
    task = await _dataBaseHelper.getTask();
    notifyListeners();
  }

  Future<void> getTaskForDateManeger(int taskDay, int taskMonth) async {
    taskForDateList = await _dataBaseHelper.getTaskForDate(taskDay, taskMonth);
    notifyListeners();
  }

  Future<void> addTaskManeger(TaskModel taskModel) async {
    await _dataBaseHelper.addTask(taskModel);
    notifyListeners();
  }

  Future<void> deleteTaskManeger(int idTask) async {
    await _dataBaseHelper.deleteTask(idTask);
    notifyListeners();
  }

  Future<void> getAllTasksManeger() async {
    allTasksList = await _dataBaseHelper.getAllTasks();
    notifyListeners();
  }

  Future<void> updateTaskManeger(
    int idTask,
    String task,
    String dateTime,
    int day,
    int month,
  ) async {
    await _dataBaseHelper.updateTask(idTask, task, dateTime, day, month);
    notifyListeners();
  }
}
