import 'package:sqflite/sqflite.dart';

class ToDoDatabase {
  late Database db;

  init() async {
    db = await openDatabase('to_do.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, description TEXT , isComplete INT,startTime TEXT , endTime TEXT,remind  INTEGER , repeat TEXT,color TEXT )');
    });
  }
}
