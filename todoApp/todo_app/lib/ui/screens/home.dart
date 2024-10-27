import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/services/theme_service.dart';
import 'package:todo_app/ui/screens/notification.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/task.dart' as task;
import '../../services/notification_service.dart';
import '../../services/notification_services.dart';
import '../size_config.dart';
import '../widgets/Task_tile.dart';
import '../widgets/button.dart';
import 'add_task.dart' as newtask;
import 'add_task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final NotificationService notificationService = NotificationService();
  final TaskController taskController = Get.put(TaskController());
  final ob = DateFormat.yMMMMd();

  DateTime date = DateTime.now();
  @override
  void initState() {
    super.initState();
    notificationService.initNotification();

    // load tasks from database
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Get.isDarkMode
              ? const Icon(Icons.wb_sunny_outlined)
              : const Icon(Icons.dark_mode),
          onPressed: () async {
            ThemeService().switchTheme();

            await NotificationService()
                .displayNotification(body: 'body', title: 'titlr');
            log('before');
            await NotificationService().scheduleNotification(
              task.Task(
                  startTime: TimeOfDay.now(),
                  remind: 5,
                  repeart: task.Repeat.daily,
                  color: pinkClr,
                  endTime: TimeOfDay.now(),
                  title: 'title',
                  date: DateTime(2025),
                  description: 'description'),
            );
            log('after');
            await NotificationService().checkPendingNotificationRequests();
            /*    await NotifyHelper().scheduledNotification(
                0,
                1,
                task.Task(
                    startTime: TimeOfDay.now(),
                    remind: 5,
                    repeart: task.Repeat.daily,
                    color: pinkClr,
                    endTime: TimeOfDay.now(),
                    title: 'title',
                    date: DateTime(2025),
                    description: 'description'));*/
          },
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('lib/assets/person.jpeg'),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            addTaskBar(context),
            addDateBar(context),
            /*
            Expanded(
              child: EasyDateTimeLine(
                 headerBuilder: (context, date) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(date.toString()),
                      if (date.day == DateTime.now().day) Text('Today'),
                      if (date.day != DateTime.now().day)
                        Text(date.day.toString())
                    ],
                  );
                },
                initialDate: DateTime.now(),
                headerProps:
                    EasyHeaderProps(dateFormatter: DateFormatter.fullDateMDY()),
                onDateChange: (selectedDate) {
                  setState(() {
                    date = selectedDate;
                  });
                },
              ),*/
            showTaskBar(),
          ],
        ),
      ),
    );
  }

  Widget showTaskBar() {
    return Expanded(
      //     flex: 4,
      child: taskController.tasks.isEmpty ? displayNoTask() : displayTasks(),
    );
  }

  Widget displayNoTask() {
    return SingleChildScrollView(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: SizeConfig.orientation == Orientation.portrait
            ? Axis.vertical
            : Axis.horizontal,
        children: [
          SizeConfig.orientation == Orientation.portrait
              ? const SizedBox(
                  height: 140,
                )
              : const SizedBox(height: 10),
          SvgPicture.asset(
            semanticsLabel: 'Task',
            'lib/assets/task.svg',
            width: MediaQuery.of(context).size.width / 6,
            height: MediaQuery.of(context).size.height / 10,
            colorFilter:
                ColorFilter.mode(primaryClr.withOpacity(0.5), BlendMode.srcIn),
          ),
          Text(
            'You don\'t have any tasks yet! \n Add new tasks to make your days productive ',
            style: Themes().subTitleStyle,
            textAlign: TextAlign.center,
          ),
          SizeConfig.orientation == Orientation.portrait
              ? const SizedBox(
                  height: 200,
                )
              : const SizedBox(height: 120),
        ],
      ),
    );
  }

  ListView displayTasks() {
    return ListView.builder(
      scrollDirection: SizeConfig.orientation == Orientation.landscape
          ? Axis.horizontal
          : Axis.vertical,
      itemCount: taskController.tasks.length,
      itemBuilder: (context, index) {
        return AnimationConfiguration.staggeredList(
            position: index,
            child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: TaskTile(index: index))));
      },
    );
  }

  DatePicker addDateBar(BuildContext context) {
    return DatePicker(
      //  height: MediaQuery.of(context).size.height / 6,
      height: 150,
      initialSelectedDate: DateTime.now(),
      DateTime.now(),
      selectionColor: const Color.fromARGB(255, 162, 118, 170),
      selectedTextColor: Colors.white,
      dateTextStyle: Themes().subTitleStyleGrey,
      monthTextStyle: Themes().subTitleStyleGrey,
      dayTextStyle: Themes().subTitleStyleGrey,
      onDateChange: (selectedDate) {
        setState(() {
          date = selectedDate;
        });
      },
    );
  }

  Row addTaskBar(BuildContext context) {
    return Row(children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ob.format(date),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
                date.day == DateTime.now().day
                    ? 'Today '
                    : DateFormat.EEEE().format(date),
                style: Theme.of(context).textTheme.headlineLarge),
          ],
        ),
      ),
      ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 162, 118, 170),
              foregroundColor: Colors.white),
          onPressed: () async {
            await Get.to(const AddTask());
            //      taskController.addTask();
          },
          icon: const Icon(Icons.add),
          label: const Text('add task'))
    ]);
  }
}
