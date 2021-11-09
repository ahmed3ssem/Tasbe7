import 'package:shared_preferences/shared_preferences.dart';

class SaveOffline{

  static Future<bool> isFirstTime() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.containsKey('isVibrate');
  }

  static Future<void> saveSetting(double fontSize , bool isVibrate , bool isSound) async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isVibrate', isVibrate);
    prefs.setBool('isSound', isSound);
    prefs.setDouble('size', fontSize);
  }

  static Future<bool> isVibrateSetting() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('isVibrate');
  }

  static Future<bool> isSoundSetting() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool('isSound');
  }

  static Future<double> fontSizeSetting() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getDouble('size');
  }

  static Future<void> firstTimeUpdate() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setString('firstTime', 'No');
  }

  static Future<bool> isFirstTimeUpdate() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.containsKey('firstTime');

  }
}