import 'package:shared_preferences/shared_preferences.dart';

class SaveOffline{

  static Future<bool> isFirstTime() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.containsKey('isVibrate');
  }
  static Future<void> saveSetting(int fontSize , bool isVibrate , bool isSound) async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.setBool('isVibrate', isVibrate);
    prefs.setBool('isSound', isSound);
    prefs.setInt('size', fontSize);
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

  static Future<int> fontSizeSetting() async{
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt('size');
  }
}