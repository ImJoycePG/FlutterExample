import 'package:flutter_example/task_obj.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDatabase {
  final String databaseName = 'tasks.db';

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);


    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE Tasks("
            "idTask INTEGER PRIMARY KEY AUTOINCREMENT,"
            "nameTask TEXT NOT NULL,"
            "completedTask INT"
          ");"
        );
      },
      version: 1,
    );
  }

  createTask (TaskObj taskObj) async {
    final Database db = await initDB();
    return db.insert('Tasks', taskObj.toMap());
  }

  deleteTask(String nameTask) async {
    final Database db = await initDB();
    await db.delete('Tasks', where: 'nameTask = ?', whereArgs: [nameTask]);
  }

  Future<List<TaskObj>> getTasks() async {
    Database db = await initDB();
    final List<Map<String, dynamic>> taskMap = await db.query('Tasks');

    return List.generate(
      taskMap.length,
      (i) => TaskObj(nameTask: taskMap[i]['nameTask'], completedTask: taskMap[i]['completedTask'])

    );
  }
}