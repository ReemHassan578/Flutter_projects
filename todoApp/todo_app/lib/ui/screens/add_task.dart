import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/ui/size_config.dart';

import '../../controllers/task_controller.dart';
import '../theme.dart';
import '../widgets/button.dart';
import '../widgets/textform.dart';

class AddTask extends StatefulWidget {
  const AddTask(this.notify, {super.key});
  final Function(Task task) notify;
  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TaskController taskController = Get.find<TaskController>();

  final List<Color> statusColors = [bluishClr, pinkClr, orangeClr];
  GlobalKey<FormState> form = GlobalKey<FormState>();
  int? status = 0;
  bool? pressRed = true;
  String? title;
  String? description;
  DateTime? date;
  // Focus nodes for each form field

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
                  onSubmit: (value) {
                    FocusScope.of(context).unfocus();
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
                  onSubmit: (value) {
                    FocusScope.of(context).unfocus();
                  },
                  hint: 'Enter note here',
                  validator: (value) {
                    if (value == null ||
                        value.trim().isEmpty ||
                        value.trim().length < 5) {
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
                      FocusScope.of(context).unfocus();
                      showDatePicker(
                              context: context,
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 90)),
                              lastDate: DateTime(2030))
                          .then(
                        (value) {
                          setState(() {
                            date = value;
                          });
                        },
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
                                  initialEntryMode: TimePickerEntryMode.input,
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then(
                            (value) => setState(() {
                              startTime = value;
                              FocusScope.of(context).unfocus();
                            }),
                          );
                        },
                      ),
                      validator: (value) {
                        //||
                        //  endTime!.hour < startTime!.hour ||
                        //endTime!.minute < startTime!.minute
                        if (startTime == null) {
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
                                    initialEntryMode: TimePickerEntryMode.input,
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(
                                        DateTime.now()
                                            .add(const Duration(minutes: 30))))
                                .then(
                              (value) => setState(() {
                                FocusScope.of(context).unfocus();
                                endTime = value;
                              }),
                            );
                          },
                        ),
                        validator: (value) {
                          //||
                          //     endTime!.hour < startTime!.hour ||
                          //   endTime!.minute < startTime!.minute
                          if (endTime == null) {
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
                  hint: (remind ?? 10) < 31
                      ? '${remind ?? 10} minutes early'
                      : '${((remind ?? 1440) ~/ (60 * 24))} days early',
                  leading: DropdownButton(
                    underline: Container(),
                    dropdownColor: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                    focusColor: Colors.white,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    items: [
                      for (int i = 10; i <= 30; i += 10)
                        DropdownMenuItem(
                          value: i,
                          child: Text('$i minutes'),
                        ),
                      for (int i = 1440; i <= 4320; i += 1440)
                        DropdownMenuItem(
                          value: i,
                          child: Text('${i ~/ (60 * 24)} day'),
                        )
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
                  hint: repeat?.name ?? 'none',
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
                selectColorRow()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row selectColorRow() {
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: statusColors[i],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(25))),
                              width: 30,
                              height: 30,
                              child: status == i
                                  ? Icon(Icons.check, color: Colors.grey[900])
                                  : null),
                          onTap: () {
                            setState(() {
                              status = i;
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
          onTap: () async {
            if (form.currentState!.validate()) {
              form.currentState!.save();
              Task task = Task(
                  startTime: startTime!,
                  remind: remind!,
                  repeat: repeat!,
                  color: status!,
                  endTime: endTime!,
                  title: title!,
                  date: date!,
                  description: description!);
              await taskController.addTask(task, context);
              widget.notify(task);

              //    NotificationService().scheduleNotification(task, date!);

              Get.back();
            } else {
              Get.snackbar('required', 'All fields are required',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.white,
                  colorText: pinkClr,
                  icon: const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                  ));
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
