import 'package:flutter/material.dart';
import 'package:seb7a/helper/save_offline.dart';
import 'package:seb7a/screens/home.dart';
import 'package:seb7a/utils/common.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SaveOffline.isFirstTime().then((value){
      if(value){
        SaveOffline.isVibrateSetting().then((value){
          setState(() {
            Common.isVibrate = value;
          });
        });
        SaveOffline.isSoundSetting().then((value){
          setState(() {
            Common.isSound = value;
          });
        });
        SaveOffline.fontSizeSetting().then((value){
          setState(() {
            Common.fontSize = value;
          });
        });
      }
    });
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Image.asset(
        "assets/image/appicon.jpeg",
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
      ),
    );
  }
}
