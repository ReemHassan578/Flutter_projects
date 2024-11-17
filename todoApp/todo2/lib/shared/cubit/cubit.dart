import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/archived_tasks/archived_tasks.dart';
import 'package:todo/modules/done_tasks/done_tasks.dart';
import 'package:todo/modules/new_tasks/new_task.dart';
import 'package:todo/shared/cubit/states.dart';

import '../../models/task.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState());

  static AppCubit get(context) {
    return BlocProvider.of(context);
  }

  late Database db;
  List<Task> tasks = [];
  List<Page> pages = [
    Page(page: const NewTasks(), title: 'New Tasks'),
    Page(page: const DoneTasks(), title: 'Done Tasks'),
    Page(page: const ArchivedTasks(), title: 'Archived Tasks'),
  ];

  int page = 0;
  bool bottomOpen = false;

  void changeBottomNavBar(int indx) {
    page = indx;
    emit(ChangeBottomAppState());
  }

  Future<void> openDB() async {
    db = await openDatabase('to_do.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT,status TEXT)');
    });
    getTasks();
    emit(OpenDBState());
  }

  Future<void> insert(Task todo) async {
    await db.insert('Tasks', todo.toMap());
    bottomOpen = false;
    tasks.add(todo);
    emit(InsertToDBState());
  }

  Future<void> getTasks() async {
    var list = await db.query('Tasks');
    tasks = list.map(
      (element) {
        return Task.fromMap(element);
      },
    ).toList();
    emit(GetFromDBState());
  }

  void pressFAB(bool isOpen) {
    bottomOpen = isOpen;
    emit(PressFABState());
  }

  Future<void> updateDB(int id, String status) async {
    await db
        .rawUpdate('UPDATE Tasks SET status = ? WHERE id = ?', [status, id]);
    await getTasks();
    emit(UpdateStatusState());
  }

  Future<void> deleteFromDB(int id) async {
    await db.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]);
    tasks.removeWhere(
      (element) {
        return element.id == id;
      },
    );
    emit(DeleteStatusState());
  }
}

class Page {
  final Widget page;
  final String title;

  Page({required this.page, required this.title});
}
