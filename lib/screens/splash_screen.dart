import 'package:flutter/material.dart';
import 'package:seb7a/helper/notification_service.dart';
import 'package:seb7a/helper/save_offline.dart';
import 'package:seb7a/screens/home.dart';
import 'package:seb7a/utils/common.dart';
import 'package:easy_localization/easy_localization.dart';

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
      } else {
        setState(() {
          SaveOffline.saveSetting(15.0, true, true);
          Common.fontSize = 15.0;
          Common.isSound = true;
          Common.isVibrate = true;
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
      body: Stack(
        children: [
          Image.asset(
            "assets/image/appicon.jpeg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(strokeWidth: 10,backgroundColor: Colors.white,),
                SizedBox(height: 5,),
                Text('welcomeMessage'.tr().toString() , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 25 , color: Colors.white),)
              ],
            ),
          )
        ],
      ),
    );
  }
}
