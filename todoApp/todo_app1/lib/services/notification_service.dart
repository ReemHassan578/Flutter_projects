import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:todo_app/ui/screens/notification.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

import '../models/task.dart';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

/*
class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });
  final int id;
  final String? title;
  final String? body;
  final String? payload;
}
*/
class NotificationService {
  //String? selectedNotificationPayload;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static const platform = MethodChannel('alarm');

  // final StreamController<ReceivedNotification>
  //   didReceiveLocalNotificationStream =
  // StreamController<ReceivedNotification>.broadcast();

//  final StreamController<String?> selectNotificationStream =
  //    StreamController<String?>.broadcast();

  Future<void> initNotification() async {
    await _configureLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('appicon');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      //onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
    //tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation(timeZoneName));

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    // const AndroidNotificationChannel channel = AndroidNotificationChannel(
    // 'uchannel id', // id
    // 'uchannel name', // name
    // description: 'uchannel description', // description
    // importance: Importance.max,
    //   );

    //   await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //       AndroidFlutterLocalNotificationsPlugin>()
    // ?.createNotificationChannel(channel);
  }

// older IOS
  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(Text(body ?? ''));
  }

// display once
  displayNotification({required String title, required String body}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('uchannel id', 'uchannel name',
            channelDescription: 'uchannel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    // show notification
    await flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: 'item x |xcvb|dvb');
  }

//scheduling notification at certain time once
  Future<void> scheduleNotification(
      Task task, DateTime date, BuildContext cntx) async {
    try {
      final String? alarmUri =
          await platform.invokeMethod<String>('getAlarmUri');
      if (alarmUri == null) {
        return;
      }

      final UriAndroidNotificationSound uriSound =
          UriAndroidNotificationSound(alarmUri);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        task.id!,
        task.title,
        task.description,

//      _nextInstanceOfNotification(hour, minute, task.date,task.remind),
        _nextInstanceOfNotification(task),
        NotificationDetails(
          android: AndroidNotificationDetails(
              //  styleInformation: ,
              visibility: NotificationVisibility.public,
              icon: 'appicon',
              sound: uriSound,
              fullScreenIntent: true,
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker',
              ' uchannel id',
              ' uchannel name',
              channelDescription: ' uchannel description'),
        ),
        androidScheduleMode: AndroidScheduleMode.alarmClock,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload:
            '${task.title}|${task.description}|${task.startTime.format(cntx)}',
      );
    } on PlatformException catch (e) {
      debugPrint("Failed to get battery level: '${e.message}'.");
    }
    // log((tz.TZDateTime.now(tz.local).subtract(Duration(hours: 1))).toString());
    //log(' ${DateTime.now()}.toString()');
    //  log('Current Device Time: ${DateTime.now()}');
    //  log('scheduled ${tz.TZDateTime.now(tz.local).add(const Duration(minutes: 2))}');
  }

  ///////////
  /// for periodic notification
  /* schedulePeriodicNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'repeating channel id', 'repeating channel name',
            channelDescription: 'repeating description');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.everyMinute, notificationDetails,
        payload: 'title|description|startTime');
  }*/

  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Get.to(() => NotificationScreen(payload: payload ?? 'vbn|nb|mnb'));
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(timeZoneName));

    // tz.setLocalLocation(tz.getLocation('Africa/Blantyre'));
  }

  deleteCertainTaskNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  tz.TZDateTime _nextInstanceOfNotification(
      //  int hour, int minutes, DateTime date,int remind,Repeat repeat)
      Task task) {
    //log('${task.id}  ${task.title} ${task.date.toString()}} ${task.description} ${task.isComplete.toString()} ${task.startTime.toString()} ${task.endTime.toString()} ${task.remind} ${task.repeat.name} ${task.color}');
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    //final tz.TZDateTime now = tz.TZDateTime(
    //  tz.local, 2025, 12, 1, task.startTime.hour, task.startTime.minute);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local,
        task.date.year,
        task.date.month,
        task.date.day,
        task.startTime.hour,
        task.startTime.minute);

    tz.TZDateTime scheduledRemindDate =
        scheduledDate.subtract(Duration(minutes: task.remind));

    if (task.repeat == Repeat.daily) {
      if (scheduledRemindDate.isBefore(now)) {
        scheduledRemindDate = scheduledRemindDate.add(const Duration(days: 1));
      }
      return scheduledRemindDate;
    } else if (task.repeat == Repeat.weekly) {
      if (scheduledRemindDate.isBefore(now)) {
        scheduledRemindDate = scheduledRemindDate.add(const Duration(days: 7));
      }

      return scheduledRemindDate;
    } else if (task.repeat == Repeat.monthly) {
      if (scheduledRemindDate.isBefore(now)) {
        DateTime nextMonth = DateTime(
            scheduledRemindDate.year, scheduledRemindDate.month + 1, 1);

        int lastDayOfNextMonth =
            DateTime(nextMonth.year, nextMonth.month + 1, 0).day;

        // Check if the task date day fits within the next month’s last day
        int dayToSet = (task.date.day <= lastDayOfNextMonth)
            ? task.date.day
            : lastDayOfNextMonth;

        // Schedule reminder for the adjusted day
        scheduledRemindDate = tz.TZDateTime(
            tz.local,
            nextMonth.year,
            nextMonth.month,
            dayToSet,
            scheduledRemindDate.hour,
            scheduledRemindDate.minute);
/////
        /*   DateTime check = DateTime(
            scheduledRemindDate.year,
            scheduledRemindDate.month + 1,
            scheduledRemindDate.day,
            scheduledRemindDate.hour,
            scheduledRemindDate.minute);
        log(check.toString());

        //      if(task.date.day==31 && date.day==31 )
        //if(task.date.day==31 && date.day==30 && check){

        //   check.month == scheduledRemindDate.month
        log((check.difference(scheduledRemindDate).inDays).toString());
        log((check.month - 1 == scheduledRemindDate.month)
            .toString()); // true task.date   false date
        scheduledRemindDate = tz.TZDateTime(
            tz.local,
            scheduledRemindDate.year,
            scheduledRemindDate.month + 1,
            (check.month - 1 == scheduledRemindDate.month) ? task.date.day : 30,
            scheduledRemindDate.hour,
            scheduledRemindDate.minute);
        log((' ${scheduledRemindDate.month}').toString());
        log('preint check ${task.date.day}');
        log(scheduledRemindDate.toString());
      }
      log(scheduledRemindDate.toString());*/
        return scheduledRemindDate;
      }
    }

    return scheduledRemindDate;
  }
// date
// next instance of week
}
