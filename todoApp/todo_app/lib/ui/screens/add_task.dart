import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/ui/size_config.dart';

import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/textform.dart';

enum Repeat { none, daily, weekly, monthly }

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final List<Color> statusColors = [bluishClr, pinkClr, orangeClr];
  GlobalKey<FormState> form = GlobalKey<FormState>();
  Color? status = bluishClr;
  bool? pressRed = true;
  String? title;
  String? description;
  DateTime? date;
  //String? startTime = DateFormat.Hms().format(DateTime.now());
  //String? endTime =
  //  DateFormat.Hms().format(DateTime.now().add(const Duration(minutes: 15)));
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  int? remind;
  Repeat? repeat;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: _appBar(),
      body: Form(
        key: form,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  'Add Task',
                  style: Themes().headingStyle,
                ),
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
                        value.trim().length < 10) {
                      return 'Enter valid description';
                    }
                    return null;
                  },
                ),
                TxtForm(
                  label: 'Date',
                  hint: DateFormat.yMd().format(date ?? DateTime.now()),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.grey,
                    ),
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
                    if (date == null) return 'Choose date';
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                        child: TxtForm(
                      label: 'Start Time',
                      hint: DateFormat('hh:mm a').format(DateTime(1, 1, 1,
                          startTime?.hour ?? 0, startTime?.minute ?? 0)),
                      leading: IconButton(
                        icon: const Icon(
                          Icons.watch_later_outlined,
                          color: Colors.grey,
                        ),
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
                        if (startTime == null ||
                            endTime!.hour < startTime!.hour ||
                            endTime!.minute < startTime!.minute) {
                          return 'Choose start time';
                        }
                        return null;
                      },
                    )),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TxtForm(
                        label: 'End Time',
                        hint: DateFormat('hh:mm a').format(DateTime(
                            1, 1, 1, endTime?.hour ?? 0, endTime?.minute ?? 0)),
                        leading: IconButton(
                          icon: const Icon(
                            Icons.watch_later_outlined,
                            color: Colors.grey,
                          ),
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
                          if (endTime == null ||
                              endTime!.hour < startTime!.hour ||
                              endTime!.minute < startTime!.minute) {
                            return 'Choose  end time';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                TxtForm(
                  label: 'Remind',
                  hint: '${remind ?? 5} minutes early',
                  leading: DropdownButton(
                    underline: Container(),
                    dropdownColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                    focusColor: Colors.white,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    items: [
                      for (int i = 5; i <= 20; i += 5)
                        DropdownMenuItem(
                          value: i,
                          child: Text('$i'),
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
                    if (remind == null) return 'Choose reminder';
                    return null;
                  },
                ),
                TxtForm(
                  label: 'Repeat',
                  hint: repeat?.name ?? 'None',
                  leading: DropdownButton(
                    underline: Container(),
                    borderRadius: BorderRadius.circular(10),
                    dropdownColor: Colors.blueGrey,
                    focusColor: Colors.white,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    items: [
                      for (final i in Repeat.values)
                        DropdownMenuItem(
                          value: i,
                          child: Text(i.name),
                        ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        repeat = value;
                      });
                    },
                  ),
                  validator: (value) {
                    if (repeat == null) return 'Choose repeat';
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                selecrColorRow()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row selecrColorRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Color', style: Themes().titleStyle),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  for (int i = 0; i < statusColors.length; i++)
                    Row(
                      children: [
                        InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: statusColors[i],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25))),
                              width: 30,
                              height: 30,
                              child: status == statusColors[i]
                                  ? Icon(Icons.check, color: Colors.grey[900])
                                  : null),
                          onTap: () {
                            setState(() {
                              status = statusColors[i];
                            });
                          },
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
        Button(
          color: primaryClr,
          text: 'Add Task',
          onTap: () {
            if (form.currentState!.validate()) {
              form.currentState!.save();
            }
          },
        ),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Get.back();
        },
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('lib/assets/person.jpeg'),
        ),
        SizedBox(width: 10),
      ],
    );
  }
}
