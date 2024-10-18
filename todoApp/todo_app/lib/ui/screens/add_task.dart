import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/ui/size_config.dart';

import '../widgets/textform.dart';

enum Repeat { none, daily, weekly, monthly }

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final List<Color> statusColors = [Colors.red, Colors.yellow, Colors.blue];
  GlobalKey<FormState> form = GlobalKey<FormState>();
  Color? status = Colors.red;
  bool? pressRed = true;
  String? title;
  String? description;
  DateTime? date = DateTime.now();
  //String? startTime = DateFormat.Hms().format(DateTime.now());
  //String? endTime =
  //  DateFormat.Hms().format(DateTime.now().add(const Duration(minutes: 15)));
  TimeOfDay? startTime = TimeOfDay.now();
  TimeOfDay? endTime = TimeOfDay.now();
  int? remind = 5;
  Repeat repeat = Repeat.none;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('lib/assets/person.jpeg'),
          )
        ],
      ),
      body: Form(
        key: form,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TxtForm(
                  onSave: (value) {
                    title = value;
                  },
                  label: 'Title',
                  hint: 'Enter title here',
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.trim().length < 3) return 'Enter valid title';
                    return null;
                  },
                ),
                TxtForm(
                  onSave: (value) {
                    description = value;
                  },
                  label: 'Note',
                  hint: 'Enter note here',
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.trim().length < 10)
                      return 'Enter valid description';
                    return null;
                  },
                ),
                TxtForm(
                  label: 'Date',
                  hint: DateFormat.yMd().format(date!),
                  leading: IconButton(
                    icon: Icon(Icons.calendar_month_outlined),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030))
                          .then(
                        (value) => setState(() {
                          date = value;
                        }),
                      );
                    },
                  ),
                  validator: (value) {
                    if (value == null) return 'choose date';
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                        child: TxtForm(
                      label: 'Start Time',
                      hint: DateFormat.Hm().format(DateTime(
                          1, 1, 1, startTime!.hour, startTime!.minute)),
                      leading: IconButton(
                        icon: Icon(Icons.watch_later_outlined),
                        onPressed: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then(
                            (value) => setState(() {
                              startTime = value;
                            }),
                          );
                        },
                      ),
                      validator: (value) {
                        if (value == null) return 'Enter valid start time';
                        return null;
                      },
                    )),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TxtForm(
                        label: 'End Time',
                        hint: DateFormat.Hm().format(
                            DateTime(1, 1, 1, endTime!.hour, endTime!.minute)),
                        leading: IconButton(
                          icon: Icon(Icons.watch_later_outlined),
                          onPressed: () {
                            showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now())
                                .then(
                              (value) => setState(() {
                                endTime = value;
                              }),
                            );
                          },
                        ),
                        validator: (value) {
                          //     if (endTime < startTime)
                          //     return 'Enter valid end time';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                TxtForm(
                  label: 'Remind',
                  hint: '$remind minutes early',
                  leading: DropdownButton(
                    items: const [
                      DropdownMenuItem(
                        child: Text('5'),
                        value: 5,
                      ),
                      DropdownMenuItem(
                        child: Text('10'),
                        value: 10,
                      ),
                      DropdownMenuItem(
                        child: Text('15'),
                        value: 15,
                      ),
                      DropdownMenuItem(
                        child: Text('20'),
                        value: 20,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        remind = value;
                      });
                    },
                  ),
                  // Icon(Icons.keyboard_arrow_down),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.trim().length < 3) return 'Enter valid remind';
                    return null;
                  },
                ),
                TxtForm(
                  label: 'Repeat',
                  hint: 'None',
                  leading: const Icon(Icons.keyboard_arrow_down),
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.trim().length < 3) return 'Enter valid repeat';
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Color'),
                        Row(
                          children: [
                            for (int i = 0; i < statusColors.length; i++)
                              InkWell(
                                child: Container(
                                    color: statusColors[i],
                                    width: 30,
                                    height: 30,
                                    child: status == statusColors[i]
                                        ? Icon(Icons.check,
                                            color: Colors.grey[900])
                                        : null),
                                onTap: () {
                                  setState(() {
                                    status = statusColors[i];
                                  });
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        form.currentState!.validate();
                        form.currentState!.save();
                        log(repeat.toString());
                      },
                      child: const Text('Add Task'))
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
