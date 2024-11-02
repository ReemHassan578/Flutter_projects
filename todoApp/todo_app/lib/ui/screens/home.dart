import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/services/theme_service.dart';
import 'package:todo_app/ui/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/task.dart';
import '../../services/notification_service.dart';
import '../size_config.dart';
import '../widgets/task_tile.dart';
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
    taskController.getTasks();
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
    return Obx(() {
      return Expanded(
        child: RefreshIndicator(
          onRefresh: () async {
            taskController.getTasks();
          },
          child:
              taskController.tasks.isEmpty ? displayNoTask() : displayTasks(),
        ),
      );
    });
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
            style: Themes().body2Style.copyWith(
                  fontSize: 12,
                ),
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

  bool isWeekly(DateTime taskDate) {
    return ((taskDate.difference(date).inDays) % 7 == 0) &&
        !date.isBefore(taskDate);
  }

  bool isMonthly(DateTime taskDate) {
///////////////////////////////////////////////////
    DateTime nextMonth = DateTime(date.year, date.month, 1);

    int lastDayOfNextMonth =
        DateTime(nextMonth.year, nextMonth.month + 1, 0).day;

    // Check if the task date day fits within the next month’s last day
    // int dayToSet = (taskDate.day <= lastDayOfNextMonth)
    //   ? taskDate.daytaskDate.day == date.day
    // : lastDayOfNextMonth;
    // return taskDate.day <= lastDayOfNextMonth;
    return (taskDate.day > lastDayOfNextMonth &&
            lastDayOfNextMonth == date.day) ||
        (taskDate.day == date.day);
    //////////////////////////////////////////////
    // Get the first day of the  month
    //DateTime firstDayOfMonth = DateTime(date.year, date.month, 1);

    // Subtract one day to get the last day of the  month
    // DateTime lastDayOfMonth =
    //   DateTime(firstDayOfMonth.year, firstDayOfMonth.month + 1, 0);

    // Check if the day is 30 or 31  &&
    //  log(firstDayOfMonth.toString());
    // log(lastDayOfMonth.toString());
    //if (taskDate.day == 31 && date.day == 30 && lastDayOfMonth.day != 31) {
    //   return true;
    //return currentDate.day == lastDayOfCurrentMonth.day;
    // }
// date ==30 and no 31  and taskDate.31
    // return (taskDate.day == date.day);
  }

  Widget displayTasks() {
    List<Task> wantedTasks = taskController.tasks.where(
      (element) {
        return ((element.date == date ||
                (element.repeat == Repeat.daily &&
                    !date.isBefore(element.date))) ||
            (isWeekly(element.date) && element.repeat == Repeat.weekly) ||
            (isMonthly(element.date) &&
                element.repeat == Repeat.monthly &&
                !date.isBefore(element.date)));
        //element.date == date ||
        //element.repeat == Repeat.daily ||
        // (isWeekly(element.date) && element.repeat == Repeat.weekly) ||
        // (isMonthly(element.date) && element.repeat == Repeat.monthly));
      },
    ).toList();

    if (wantedTasks.isEmpty) {
      return displayNoTask();
    }

    return ListView.builder(
        scrollDirection: SizeConfig.orientation == Orientation.landscape
            ? Axis.horizontal
            : Axis.vertical,
        itemCount: taskController.tasks.length,
        itemBuilder: (context, index) {
          var task = taskController.tasks[index];
          if ((task.date == date ||
                  (task.repeat == Repeat.daily && !date.isBefore(task.date))) ||
              (isWeekly(task.date) && task.repeat == Repeat.weekly) ||
              (isMonthly(task.date) &&
                  task.repeat == Repeat.monthly &&
                  !date.isBefore(task.date))) {
            //   NotificationService()
            //     .scheduleNotification(taskController.tasks[index], date);
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(
                  child: TaskTile(
                    task: taskController.tasks[index],
                    onComplete: () {
                      taskController.updateTask(task, context);
                      NotificationService()
                          .deleteCertainTaskNotification(task.id!);
                      Get.back();
                    },
                    ondelete: () {
                      taskController.deleteTask(task);
                      NotificationService()
                          .deleteCertainTaskNotification(task.id!);

                      Get.back();
                    },
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }

  DatePicker addDateBar(BuildContext context) {
    return DatePicker(
      //  height: MediaQuery.of(context).size.height / 6,
      height: 110,
      initialSelectedDate: DateTime.now(),
      DateTime.now().subtract(const Duration(days: 3)),
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
                    : DateFormat.yMd().format(date),
                style: Themes().titleStyle),
          ],
        ),
      ),
      ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 162, 118, 170),
              foregroundColor: Colors.white),
          onPressed: () async {
            await Get.to(AddTask((Task task) {
              NotificationService().scheduleNotification(task, date);
            }));
          },
          icon: const Icon(Icons.add),
          label: const Text('add task'))
    ]);
  }
}
