import 'package:flutter/material.dart';
import 'package:flutter_calendar/helper/db_helper.dart';
import 'package:flutter_calendar/model/task_model.dart';

class TaskManager extends ChangeNotifier {
  final DataBaseHelper _dataBaseHelper = DataBaseHelper();

  List<TaskModel> taskForDateList = [];
  List<TaskModel> taskCircleForDateList = [];
  List<TaskModel> allTasksList = [];
  TaskModel? task;
  Map<String, List<TaskModel>> allTasksMap = {};

  Future<void> getTask() async {
    task = await _dataBaseHelper.getTask();
    notifyListeners();
  }

  Future<void> getTaskForDateManeger(int taskDay, int taskMonth) async {
    taskForDateList = await _dataBaseHelper.getTaskForDate(taskDay, taskMonth);
    notifyListeners();
  }

  Future<void> getTaskCircleForDateManeger(int taskDay, int taskMonth) async {
    //taskCircleForDateList =
    //  task.where((task) => task.day == day && task.month == month).toList();
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

    for (var task in allTasksList) {}

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
