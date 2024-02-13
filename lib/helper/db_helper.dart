import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

String taskTable = "taskTable";
String id = "idColumn";
String task = "taskColumn";
String dateTime = "dateColumn";
int isDone = 1;

class DataBaseHelper {
  DataBaseHelper.internal();

  static final DataBaseHelper instance = DataBaseHelper.internal();
  static Database? _db;

  Future<Database> get db async {
    if(_db != null){
      return _db!;
    }else{
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    final String dbPath = await getDatabasesPath();
    final String path = join(dbPath, "task_db.db");

    Database taskDb = await openDatabase(path, version: 1, onCreate: (db, newerVersion) async {
        await db.execute('CREATE TABLE $taskTable ($id INTEGER PRIMARY KEY AUTOINCREMENT, $task TEXT, $dateTime TEXT,'
        '$isDone INTEGER)');
      },
    );

    return taskDb;
  }
}