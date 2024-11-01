import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db/database.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> tasks = <Task>[].obs;

  Future<void> addTask(Task task, BuildContext cntx) async {
    int id = await ToDoDatabase.addTaskToDb(task, cntx);

    task.id = id;
    tasks.add(task);
  }

  Future<void> getTasks() async {
    final List<Map<String, dynamic>> list = await ToDoDatabase.loadTaskFromDb();

    tasks.assignAll(list.map(
      (e) {
        return Task.fromJson(e);
      },
    ));
  }

  Future<int> deleteTask(Task task) {
    tasks.remove(task);
    return ToDoDatabase.deleteTaskFromDb(task);
  }

  Future<int> updateTask(Task task, BuildContext cntx) {
    tasks.remove(task);
    task.completeTask();
    tasks.add(task);
    return ToDoDatabase.editTask(task.id!, cntx);
  }
}
