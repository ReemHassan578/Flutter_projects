import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/services/theme_service.dart';
import 'package:todo_app/ui/screens/notification.dart';

import '../../models/task.dart';
import 'add_task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ob = DateFormat.yMMMMd();
  List<Task> tasks = [
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
            'Reloaded 1 of 1101 libraries in 18,472ms (compile: 15551 ms, reload: 765 ms, reassemble: 1035 ms).Restarted application in 8,748ms.Reloaded 1 of 1101 libraries in 1,204ms (compile: 138 ms, reload: 453 ms, reassemble: 411 ms).Reloaded 0 libraries in 327ms (compile: 47 ms, reload: 0 ms, reassemble: 91 ms).'),
    Task(
        title: 'taet',
        date: DateTime.now(),
        description:
            'Reloaded 1 of 1101 libraries in 18,472ms (compile: 15551 ms, reload: 765 ms, reassemble: 1035 ms).Restarted application in 8,748ms.Reloaded 1 of 1101 libraries in 1,204ms (compile: 138 ms, reload: 453 ms, reassemble: 411 ms).Reloaded 0 libraries in 327ms (compile: 47 ms, reload: 0 ms, reassemble: 91 ms).')
  ];
  final DatePickerController _controller = DatePickerController();

  DateTime date = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.dark_mode),
          onPressed: () {
            ThemeService().switchTheme();
            Get.to(NotificationScreen(
              payload: 'fgh|fgh|dfg',
            ));
          },
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('lib/assets/person.jpeg'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(children: [
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
                  onPressed: () {
                    Get.to(AddTask());
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('add task'))
            ]),
            Expanded(
              flex: 2,
              child: DatePicker(
                height: MediaQuery.of(context).size.height / 6,
                controller: _controller,
                initialSelectedDate: DateTime.now(),
                DateTime.now(),
                selectionColor: const Color.fromARGB(255, 162, 118, 170),
                selectedTextColor: Colors.white,
                onDateChange: (selectedDate) {
                  setState(() {
                    date = selectedDate;
                  });
                },
              ),
            ),
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

            Expanded(
              flex: 4,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isDismissible: false,
                        context: context,
                        builder: (context) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            height: MediaQuery.of(context).size.height / 3,
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (!tasks[index].isComplete)
                                  OutlinedButton(
                                    onPressed: () {
                                      tasks[index].completeTask();
                                    },
                                    child: const Text('Task Completed'),
                                    style: OutlinedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 162, 118, 170),
                                        foregroundColor: Colors.white),
                                  ),
                                OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      tasks.remove(tasks[index]);
                                    });
                                  },
                                  child: const Text('Delete Task '),
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                ),
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: Colors.black),
                                  child: const Text('Close'),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      color: Colors.amber,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Text(
                            tasks[index].title,
                          ),
                          Text(tasks[index].description),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
