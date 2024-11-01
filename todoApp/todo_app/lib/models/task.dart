// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../db/database.dart';

enum Repeat { none, daily, weekly, monthly }

class Task {
  int? id;
  late String title;
  late DateTime date;
  late String description;
  late bool isComplete;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  late int remind;
  late Repeat repeat;
  late int color;

  Task({
    this.id,
    required this.startTime,
    required this.remind,
    required this.repeat,
    required this.color,
    required this.endTime,
    required this.title,
    required this.date,
    required this.description,
  }) {
    isComplete = false;
  }

  void completeTask() {
    isComplete = true;
  }

  Map<String, Object> toJson(BuildContext cntx) {
    return {
      'title': title,
      'date': dateFormat.format(date),
      'description': description,
      'isComplete': isComplete.toString(),
      'startTime': startTime.format(cntx),
      'endTime': endTime.format(cntx),
      'remind': remind,
      'repeat': repeat.name,
      'color': color.toString(),
    };
  }

  Repeat _repeatValue(String repeatt) {
    if (repeatt == 'none') {
      return Repeat.none;
    } else if (repeatt == 'daily') {
      return Repeat.daily;
    } else if (repeatt == 'weekly') {
      return Repeat.weekly;
    } else {
      return Repeat.monthly;
    }
  }

  Task.fromJson(Map<String, dynamic> map) {
    DateTime endddTimme = DateFormat('hh:mm a').parse(map['endTime'].trim());
    DateTime startTimme = DateFormat('hh:mm a').parse(map['startTime'].trim());
    List<String> datte = map['date'].split('/');

    id = map['id'] as int;
    title = map['title'] as String;
    date =
        DateTime(int.parse(datte[2]), int.parse(datte[0]), int.parse(datte[1]));
    description = map['description'] as String;
    isComplete = map['isComplete'] == 'true' ? true : false;
    startTime = TimeOfDay.fromDateTime(startTimme);
    endTime = TimeOfDay.fromDateTime(endddTimme);
    remind = map['remind'] as int;
    repeat = _repeatValue(map['repeat']);
    color = map['color'] as int;
  }
}
