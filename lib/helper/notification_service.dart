import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{


   Future<void> repeatNotification() async {
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
     AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
        'repeating channel id', 'repeating channel name',
        channelDescription: 'repeating description');
     NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'appName'.tr().toString(),
        getRandomNumber(), RepeatInterval.everyMinute, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  String getRandomNumber(){
    List<String> notificationBodyList = ['notificationBody1' , 'notificationBody2' , 'notificationBody3' , 'notificationBody4' , 'notificationBody5' , 'notificationBody6' , 'notificationBody7' , 'notificationBody8' , 'notificationBody9'];
    Random rnd;
    int min = 0;
    int max = 5;
    rnd = new Random();
    int r = min + rnd.nextInt(max - min);
   return notificationBodyList[r].tr().toString();
  }
}