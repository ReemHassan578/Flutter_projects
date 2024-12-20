import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/task.dart';
import '../size_config.dart';
import '../theme.dart';
import 'button.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.onComplete,
    required this.ondelete,
  });

  final Task task;
  final Function() onComplete;
  final Function() ondelete;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        buildModalSheet(context);
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        width: SizeConfig.orientation == Orientation.landscape
            ? SizeConfig.screenWidth / 3
            : SizeConfig.screenWidth,
        height: SizeConfig.orientation == Orientation.landscape
            ? SizeConfig.screenHeight / 4
            : SizeConfig.screenHeight / 7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colorCon(task.color),
        ),
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(task.title,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.access_alarm_rounded,
                            color: Colors.grey[200],
                            size: 18,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                              '${task.startTime.format(context).toString()} - ${task.endTime.format(context).toString()}',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[100],
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        task.description,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[100],
                        ),
                      ),
                    ]),
              ),
            ),
            Container(
              color: Colors.grey[200]!.withOpacity(0.7),
              height: getProportionateScreenHeight(30),
              width: 0.5,
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                task.isComplete ? 'COMPLETED' : 'TODO',
                style: Themes().subTitleStyleWhite,
              ),
            )
          ],
        ),
      ),
    );
  }

  void buildModalSheet(BuildContext context) {
    Get.bottomSheet(
      isDismissible: false,
      Container(
        color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(10),
        height: SizeConfig.screenHeight / 4,
        width: SizeConfig.screenWidth,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!task.isComplete)
                Button(
                  text: 'Task Completed',
                  onTap: onComplete,
                  color: Colors.red,
                ),
              if (task.isComplete)
                SizedBox(height: getProportionateScreenHeight(40)),
              SizedBox(height: getProportionateScreenHeight(10)),
              Button(
                text: 'Delete Task ',
                onTap: ondelete,
                color: primaryClr,
              ),
              Divider(
                color: Get.isDarkMode ? Colors.grey : darkGreyClr,
              ),
              Button(
                onTap: () {
                  Get.back();
                },
                color: Colors.black,
                text: 'Close',
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
    /*showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          height: MediaQuery.of(context).size.height / 3,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (!task.isComplete)
                Button(
                  text: 'Task Completed',
                  onTap: () {
                    task.completeTask();
                  },
                  color: Colors.red,
                ),
              Button(
                text: 'Delete Task ',
                onTap: () {
                  TaskController().tasks.remove(task);
                },
                color: primaryClr,
              ),
              const Divider(
                color: Colors.grey,
              ),
              Button(
                onTap: () {
                  Navigator.of(context).pop();
                },
                color: Colors.black,
                text: 'Close',
              )
            ],
          ),
        );
      },
    );*/
  }

  Color colorCon(int indx) {
    switch (indx) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return orangeClr;
      default:
        return white;
    }
  }
}
