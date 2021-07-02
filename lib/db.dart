import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'entities/task.dart';

class DB {
  DB._();

  static final DB instance = DB._();
  static late Database _database;
  StreamController<List<Task>> taskListStream = StreamController();

  Future<void> open() async {
    final databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo.db');
    print(path);

    _database = await openDatabase(path, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE tasks(id INTEGER PRIMARY KEY, name TEXT, done INTEGER)',
      );
    }, version: 1);

    updateTaskListStream();
  }

  Future<void> close() async {
    await _database.close();
  }

  Future<void> addTask(Task task) async {
    await _database.insert('tasks', task.toJson());

    updateTaskListStream();
  }

  Future<void> updateTask(Task task) async {
    await _database
        .update('tasks', task.toJson(), where: 'id = ?', whereArgs: [task.id]);

    updateTaskListStream();
  }

  Future<List<Task>> getTaskList() async {
    final res = await _database.query('tasks');

    return res.map((task) => Task.fromJson(task)).toList();
  }

  Future<void> updateTaskListStream() async {
    taskListStream.add(await getTaskList());
  }
}
