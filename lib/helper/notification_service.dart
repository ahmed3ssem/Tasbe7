import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService{

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final AndroidNotificationDetails _androidNotificationDetails =
  const AndroidNotificationDetails(
    'channel ID',
    'channel name',
    playSound: true,
    priority: Priority.high,
    importance: Importance.high,
  );

  Future<void> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_launcher');


    final InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid,);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleNotifications() async {
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: _androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'appName'.tr().toString(),
        'notificationBody'.tr().toString(), RepeatInterval.daily, platformChannelSpecifics,
        androidAllowWhileIdle: true);
    //for emoji Mac: hit Control + Command + Space , Windows:key" + ; (semicolon).
  }
}