import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

//Provider
import '../provider/tasks_provider.dart';

class ToDoHelper {
  static Database? _datebase;
  static Future<Database> get getDatabase async =>
      _datebase ??= await _initDatabase();

  static Future<Database> _initDatabase() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'todo.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    return await db.execute(
        'CREATE TABLE Todo (id TEXT PRIMARY KEY, task TEXT, date TEXT, isComplete INTEGER)');
  }

  //Successful
  static Future<int> addTask(Task items) async {
    //initalize bit
    var bit = items.isComplete ? 1 : 0;
    //Make insert query to the table
    Database db = await getDatabase;
    return await db.rawInsert(
      'INSERT INTO Todo (id, task, date, isComplete) VALUES ("${items.id}", "${items.title}", "${items.date.toString()}", $bit)',
    );
  }

  static Future<List<Task>> getTask() async {
    //See the data comes from the db
    var db = await getDatabase;
    final List<Map<String, dynamic>> data = await db.query('Todo');
    final List<Task> _loadedData = [];
    data
        .map((task) => {
              _loadedData.add(
                Task(
                  id: DateTime.parse(task['id']).toString(),
                  title: task['task'],
                  date: DateTime.parse(task['date']),
                  isComplete: task['isComplete'] == 0 ? false : true,
                ),
              )
            })
        .toList();
    return _loadedData;
  }

  static Future<void> updateTaskTitle(String id, String title) async {
    //Get the database
    final db = await getDatabase;
    await db.rawUpdate('UPDATE Todo SET task = ? WHERE id = ?', [title, id]);
  }

  static Future<void> updateTaskComplete(String id, int isComplete) async {
    //Get the datebase
    final db = await getDatabase;
    await db.rawUpdate(
        'UPDATE Todo SET isComplete = ? WHERE id = ?', [isComplete, id]);
  }

  static Future<void> deleteTask(String id) async {
    //databse
    final db = await getDatabase;
    await db.rawDelete('DELETE FROM Todo WHERE id = "$id"');
  }

  static Future<void> dropDatabase() async {
    //delete the database for isComplete
    Database db = await getDatabase;
    final result = await db.delete('todo');
    // ignore: avoid_print
    print(result);
  }
}
