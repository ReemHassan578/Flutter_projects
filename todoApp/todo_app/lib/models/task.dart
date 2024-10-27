import 'package:flutter/material.dart';

enum Repeat { none, daily, weekly, monthly }

class Task {
  //var id;
  final String title;
  final DateTime date;
  final String description;
  bool isComplete;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int remind;
  final Repeat repeart;
  final Color color;

  Task({
    required this.startTime,
    required this.remind,
    required this.repeart,
    required this.color,
    required this.endTime,
    required this.title,
    required this.date,
    required this.description,
  }) : isComplete = true;
  void completeTask() {
    isComplete = true;
  }
}
