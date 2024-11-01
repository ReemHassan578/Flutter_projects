import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

final dateFormat = DateFormat.yMd();

class ToDoDatabase {
  static const String _dbname = 'to_do.db';
  static const String _tableName = 'Tasks';
  static int _version = 1;
  static late Database db;

  static Future<void> initDb() async {
    String path = await getDatabasesPath() + _dbname;
    db = await openDatabase(path, version: _version,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, date TEXT, description TEXT , isComplete INTEGER,startTime TEXT , endTime TEXT,remind  INTEGER , repeat TEXT,color INTEGER )');
    });
  }

  static Future<List<Map<String, dynamic>>> loadTaskFromDb() async {
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT * FROM $_tableName');

    return list;
  }

  static Future<int> addTaskToDb(Task task, BuildContext cntx) async {
    return await db.insert(_tableName, task.toJson(cntx));
  }

  static Future<int> deleteTaskFromDb(Task task) {
    return db.delete(_tableName, where: 'id = ?', whereArgs: [task.id]);
  }

  static Future<int> editTask(int id, BuildContext cntx) {
    return db.update(_tableName, {'isComplete': 'true'},
        where: 'id = ?', whereArgs: [id]);
  }
}
