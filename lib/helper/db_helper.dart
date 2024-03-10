import 'package:flutter_calendar/model/task_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String taskTable = "taskTable";
String id = "idColumn";
String task = "taskColumn";
String dateTime = "dateColumn";
String day = "dayColumn";
String month = "monthColumn";

class DataBaseHelper {
  DataBaseHelper.internal();

  factory DataBaseHelper() => instance;

  static final DataBaseHelper instance = DataBaseHelper.internal();
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final String dbPath = await getDatabasesPath();
    print("Database path: $dbPath");
    final String path = join(dbPath, "task_db.db");

    Database taskDb = await openDatabase(
      path,
      version: 1,
      onCreate: (db, newerVersion) async {
        await db.execute(
            'CREATE TABLE $taskTable ($id INTEGER PRIMARY KEY AUTOINCREMENT, $task TEXT, $dateTime TEXT,'
            '$day INTEGER, $month INTEGER)');
      },
    );

    return taskDb;
  }

  Future<TaskModel> getTask() async {
    Database taskDb = await db;

    List<Map<String, dynamic>> listOfTask = await taskDb.query(
      taskTable,
      columns: [
        id,
        task,
        dateTime,
        day,
        month,
      ],
      where: "idColumn = ?",
      whereArgs: [id],
    );

    return TaskModel.fromJson(listOfTask.first);
  }

  Future<List<TaskModel>> getAllTasks() async {
    Database taskDb = await db;

    List listOfMap = await taskDb.rawQuery("SELECT * FROM $taskTable");
    List<TaskModel> listOftasks = [];

    for (Map<String, dynamic> map in listOfMap) {
      listOftasks.add(TaskModel.fromJson(map));
    }

    return listOftasks;
  }

  Future<void> addTask(TaskModel taskModel) async {
    Database taskDb = await db;

    Map<String, dynamic> taskMap = taskModel.toJson();

    await taskDb.insert(taskTable, taskMap);
  }

  Future<List<TaskModel>> getTaskForDate(int taskDay, int taskMonth) async {
    Database taskDb = await db;

    List<Map<String, dynamic>> listOfTask = await taskDb.query(
      taskTable,
      columns: [
        id,
        task,
        dateTime,
        day,
        month,
      ],
      where: "$day = ? AND $month = ?",
      whereArgs: [taskDay, taskMonth],
    );

    return listOfTask.map((taskMap) => TaskModel.fromJson(taskMap)).toList();
  }

  Future deleteDB() async {
    Database taskDb = await db;
    taskDb.delete(taskTable);
  }

  Future deleteTask(int idTask) async {
    Database taskDb = await db;
    taskDb.delete(
      taskTable,
      where: "$id = ?",
      whereArgs: [idTask],
    );
  }

  // Future<int> updateTask(int id) async {
  //   Database taskDb = await db;

  //   return await taskDb.update(
  //     taskTable,

  //   );
  //}
}
