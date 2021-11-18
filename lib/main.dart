import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:seb7a/screens/home.dart';
import 'package:seb7a/screens/splash_screen.dart';
import 'helper/notification_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
    child: MyApp(),
    path: "resources",
    saveLocale: true,
    supportedLocales: [
      Locale('ar','AR'),
    ],
  ));
  NotificationService().init();
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "تسابيح",
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}