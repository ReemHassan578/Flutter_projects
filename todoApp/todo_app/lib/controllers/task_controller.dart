import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/theme.dart';

import '../models/task.dart';

class TaskController extends GetxController {
  final List<Task> tasks = [
    Task(
        startTime: TimeOfDay.now(),
        remind: 5,
        repeart: Repeat.daily,
        color: pinkClr,
        endTime: TimeOfDay.now(),
        title: 'title',
        date: DateTime(2025),
        description: 'description')
    /* Task(
        title: 'taet',
        date: DateTime.now(),
        description:
            'Reloaded 1 of 1101 libraries in 18,472ms (compile: 15551 ms, reload: 765 ms, reassemble: 1035 ms).Restarted application in 8,748ms.Reloaded 1 of 1101 libraries in 1,204ms (compile: 138 ms, reload: 453 ms, reassemble: 411 ms).Reloaded 0 libraries in 327ms (compile: 47 ms, reload: 0 ms, reassemble: 91 ms).'),
    Task(
        title: 'taet',
        date: DateTime.now(),
        description:
            'Reloaded 1 of 1101 libraries in 18,472ms (compile: 15551 ms, reload: 765 ms, reassemble: 1035 ms).Restarted application in 8,748ms.Reloaded 1 of 1101 libraries in 1,204ms (compile: 138 ms, reload: 453 ms, reassemble: 411 ms).Reloaded 0 libraries in 327ms (compile: 47 ms, reload: 0 ms, reassemble: 91 ms).'),
    Task(
        title: 'taet',
        date: DateTime.now(),
        description:
            'Reloaded 1 of 1101 libraries in 18,472ms (compile: 15551 ms, reload: 765 ms, reassemble: 1035 ms).Restarted application in 8,748ms.Reloaded 1 of 1101 libraries in 1,204ms (compile: 138 ms, reload: 453 ms, reassemble: 411 ms).Reloaded 0 libraries in 327ms (compile: 47 ms, reload: 0 ms, reassemble: 91 ms).'),
    Task(
        title: 'taet',
        date: DateTime.now(),
        description:
            'Reloaded 1 of 1101 libraries in 18,472ms (compile: 15551 ms, reload: 765 ms, reassemble: 1035 ms).Restarted application in 8,748ms.Reloaded 1 of 1101 libraries in 1,204ms (compile: 138 ms, reload: 453 ms, reassemble: 411 ms).Reloaded 0 libraries in 327ms (compile: 47 ms, reload: 0 ms, reassemble: 91 ms).'),
    Task(
        title: 'taet',
        date: DateTime.now(),
        description:
            'Reloaded 1 of 1101 libraries in 18,472ms (compile: 15551 ms, reload: 765 ms, reassemble: 1035 ms).Restarted application in 8,748ms.Reloaded 1 of 1101 libraries in 1,204ms (compile: 138 ms, reload: 453 ms, reassemble: 411 ms).Reloaded 0 libraries in 327ms (compile: 47 ms, reload: 0 ms, reassemble: 91 ms).'),
    Task(
        title: 'taet',
        date: DateTime.now(),
        description:
            'Reloaded 1 of 1101 libraries in 18,472ms (compile: 15551 ms, reload: 765 ms, reassemble: 1035 ms).Restarted application in 8,748ms.Reloaded 1 of 1101 libraries in 1,204ms (compile: 138 ms, reload: 453 ms, reassemble: 411 ms).Reloaded 0 libraries in 327ms (compile: 47 ms, reload: 0 ms, reassemble: 91 ms).')
 */
  ];
  addTask(Task task) {}

  getTasks() {}
}
