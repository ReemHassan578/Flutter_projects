import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
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
  // final StreamController<ReceivedNotification>
  //   didReceiveLocalNotificationStream =
  // StreamController<ReceivedNotification>.broadcast();

//  final StreamController<String?> selectNotificationStream =
  //    StreamController<String?>.broadcast();

  Future<void> initNotification() async {
    await _configureLocalTimeZone();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('appicon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final InitializationSettings initializationSettings =
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

//scheduling notification every certain duration
  scheduleNotification(Task task) async {
    // final scheduledTime = DateTime.now().add(const Duration(minutes: 1));
    //   final scheduledTime =
    //     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 55));
    /* DateTime timenow = DateTime.now()
        .subtract(Duration(hours: 1))
        .add(const Duration(minutes: 2));

    //  Convert to tz.TZDateTime in local timezone
    final tz.TZDateTime scheduledTimeTz = tz.TZDateTime.from(timenow, tz.local);*/

    // Step 4: Log for debugging

    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'scheduled title',
      'scheduled body',
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 20)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
            //    fullScreenIntent: true,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
            ' uchannel id',
            ' uchannel name',
            channelDescription: ' uchannel description'),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: '${task.title}|${task.description}|${task.startTime}',
    );
    // log((tz.TZDateTime.now(tz.local).subtract(Duration(hours: 1))).toString());
    //log(' ${DateTime.now()}.toString()');
    //  log('Current Device Time: ${DateTime.now()}');
    //  log('scheduled ${tz.TZDateTime.now(tz.local).add(const Duration(minutes: 2))}');
  }

  ///////////
  /// for periodic notification
  schedulePeriodicNotification() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            'repeating channel id', 'repeating channel name',
            channelDescription: 'repeating description');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.everyMinute, notificationDetails,
        androidAllowWhileIdle: true);
  }

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
    log(timeZoneName);
    //tz.setLocalLocation(tz.getLocation(timeZoneName));

    tz.setLocalLocation(tz.getLocation('Africa/Blantyre'));
  }

  Future<void> checkPendingNotificationRequests() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    log('${pendingNotificationRequests.length} pending notification ');

    for (PendingNotificationRequest pendingNotificationRequest
        in pendingNotificationRequests) {
      log("${pendingNotificationRequest.id} ${pendingNotificationRequest.payload ?? ""}");
    }
  }
}
