import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:nice_button/NiceButton.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:seb7a/helper/db_helper.dart';
import 'package:seb7a/helper/notification_service.dart';
import 'package:seb7a/helper/save_offline.dart';
import 'package:seb7a/screens/evning_azkar.dart';
import 'package:seb7a/screens/my_praises.dart';
import 'package:seb7a/screens/praise.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:seb7a/screens/praise_competition.dart';
import 'package:seb7a/screens/sleeping_azkar.dart';
import 'package:seb7a/utils/common.dart';
import 'package:seb7a/widgets/show_message.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';
import 'morning_azkar.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController praiseNameController = new TextEditingController();
  TextEditingController praiseValueController = new TextEditingController();
  RegExp numberRegExp = new RegExp("^[0-9]*\$");
  bool checkPraiseExist;
  var firstColor = Color(0xff5b86e5), secondColor = Color(0xff36d1dc);
  int id;

  final _dialog = RatingDialog(
    // your app's name?
    title: Text('rateUsDialogTitle'.tr().toString()),
    // encourage your user to leave a high rating?
    message:
    Text('rateUsDialogMessage'.tr().toString()),
    // your app's logo?
    image:  Image.asset('assets/image/appicon.jpeg',width: 50,height: 50,),
    submitButtonText: 'submit'.tr().toString(),
    commentHint: 'commentHint'.tr().toString(),
    onCancelled: () => print('cancelled'),
    onSubmitted: (response) {
      print('rating: ${response.rating}, comment: ${response.comment}');
      // TODO: add your own logic
      if (response.rating < 3.0) {
        // send their comments to your email or anywhere you wish
        // ask the user to contact you instead of leaving a bad review
      } else {
        //go to app store
        StoreRedirect.redirect(androidAppId: 'com.assem.tasabeh');
      }
    },
  );

  void addNewPraise(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          //title: Text('TextField in Dialog'),
          content: SingleChildScrollView(
            child: Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(right: 10 , left: 10),
              child: Column(
                children: [
                  TextField(
                    controller: praiseNameController,
                    decoration: InputDecoration(
                      hintText: "dialogTextFieldName".tr().toString(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('dialogAddButton'.tr().toString()),
              onPressed: () {
                if(praiseNameController.value.text.toString().isEmpty){
                  ToastMessage.showMessage('dialogMissingDataError'.tr().toString(), Colors.red);
                } else {
                  DBHelper.addPraise('praise_table', {
                    'praiseName': praiseNameController.value.text.toString(),
                    'praiseValue': 0
                  }).then((value) {
                    setState(() {
                      id = value[0]['id'];
                    });
                    print('success');
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Praise(praiseNameController.value.text.toString(), 0 , id)));
                  }).catchError((error) => print(error));
                }
              },
            ),
            FlatButton(
                child: Text('dialogCancleButton'.tr().toString() , style: TextStyle(color: Colors.red),),
                onPressed: ()=>Navigator.pop(context)
            ),
          ],
        );
      },
    );
  }

  void addPraiseChallenge(BuildContext context) async{
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          //title: Text('TextField in Dialog'),
          content: Container(
            height: 115,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(right: 10 , left: 10),
            child: Column(
              children: [
                TextField(
                  controller: praiseNameController,
                  decoration: InputDecoration(
                    hintText: "dialogTextFieldName".tr().toString(),
                  ),
                ),
                TextField(
                  controller: praiseValueController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                  ],
                  decoration: InputDecoration(
                    hintText: "challenageDialogTextFieldValue".tr().toString(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('dialogAddButton'.tr().toString()),
              onPressed: () {
                if(praiseNameController.value.text.toString().isEmpty || praiseValueController.value.text.isEmpty){
                  ToastMessage.showMessage('challengDialogMissingDataError'.tr().toString(), Colors.red);
                } else if(!numberRegExp.hasMatch(praiseValueController.text.toString())){
                  ToastMessage.showMessage('dialogPraiseValueError'.tr().toString(), Colors.red);
                } else {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Praisecompetition(praiseNameController.value.text.toString(), 0 , int.parse(praiseValueController.value.text.toString()))));
                }
              },
            ),
            FlatButton(
              child: Text('dialogCancleButton'.tr().toString() , style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        settingDialog();
        break;
      case 1:
        Share.share('https://play.google.com/store/apps/details?id=com.assem.tasabeh');
        break;
      case 2:
        _launchURL('a7med.assem@gmail.com', 'Tasabee7 Suggestions',);
        break;
      case 3:
        showDialog(
          context: context,
          builder: (context) => _dialog,
        );
    }
  }

  _launchURL(String toMailId, String subject) async {
    final Email email = Email(
      subject: 'Tasabee7 Suggestions',
      recipients: ['a7med.assem@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  void settingDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("setting".tr().toString()),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: SingleChildScrollView(
                child: Container(
                  height: 195,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(right: 10 , left: 10),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('fontSize'.tr().toString() , style: TextStyle(color: Colors.black , fontSize: 15),),
                        ),
                      ),
                      SfSlider(
                        min: 10,
                        max: 30,
                        value: Common.fontSize,
                        interval: 5,
                        showTicks: true,
                        showLabels: true,
                        minorTicksPerInterval: 1,
                        onChanged: (dynamic value){
                          setState(() {
                            Common.fontSize = value;
                          });
                        },
                      ),
                      SizedBox(height: 15,),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Checkbox(
                                  value: Common.isSound,
                                  onChanged: (val)=> setState(() {Common.isSound = val;})
                              ),
                               Text(
                                'applySound'.tr().toString(),
                                style: const TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              new Checkbox(
                                  value: Common.isVibrate,
                                  onChanged: (val)=> setState(() {Common.isVibrate = val;})
                              ),
                               Text(
                                'applyVibrate'.tr().toString(),
                                style: const TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('dialogEditButton'.tr().toString()),
                  onPressed: () {
                    setState((){
                      SaveOffline.saveSetting(Common.fontSize, Common.isVibrate, Common.isSound);
                    });
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                    child: Text('dialogCancleButton'.tr().toString() , style: TextStyle(color: Colors.red),),
                    onPressed: ()=>Navigator.pop(context)
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("homeAppBarTittle".tr().toString() , style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          Theme(
            data: Theme.of(context).copyWith(
                textTheme: TextTheme().apply(bodyColor: Colors.white),
                dividerColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.white)),
            child: PopupMenuButton<int>(
              color: Colors.white,
              itemBuilder: (context) => [
                PopupMenuItem<int>(value: 0, child: Text("setting".tr().toString() , style: TextStyle(color: Colors.black),)),
                PopupMenuItem<int>(value: 2, child: Text("suggestions".tr().toString() , style: TextStyle(color: Colors.black),)),
                PopupMenuItem<int>(value: 1, child: Text("shareApp".tr().toString() , style: TextStyle(color: Colors.black),)),
                PopupMenuItem<int>(value: 3, child: Text("rateUs".tr().toString() , style: TextStyle(color: Colors.black),)),
              ],
              onSelected: (item) => SelectedItem(context, item),
            ),
          ),
        ],
      ),
      body:  Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/bg.jpeg'), fit: BoxFit.fill,),
          //shape: BoxShape.circle,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70,),
              NiceButton(
                  radius: 40,
                  padding: const EdgeInsets.all(15),
                  text: "addPraise".tr().toString(),
                  gradientColors: [secondColor, firstColor],
                  onPressed: (){
                    praiseNameController.clear();
                    praiseValueController.clear();
                    addNewPraise(context);
                  }
              ),
              SizedBox(height: 20,),
              NiceButton(
                  radius: 40,
                  padding: const EdgeInsets.all(15),
                  text: "myChallenges".tr().toString(),
                  gradientColors: [secondColor, firstColor],
                  onPressed: (){
                    praiseNameController.clear();
                    praiseValueController.clear();
                    addPraiseChallenge(context);
                  }
              ),
              SizedBox(height: 20,),
              NiceButton(
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "myPraises".tr().toString(),
                gradientColors: [secondColor, firstColor],
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => MyPraises())),
              ),
              SizedBox(height: 20,),
              NiceButton(
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "MorningAzkar".tr().toString(),
                gradientColors: [secondColor, firstColor],
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => Morningazkar())),
              ),
              SizedBox(height: 20,),
              NiceButton(
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "EvningAzkar".tr().toString(),
                gradientColors: [secondColor, firstColor],
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => EvningAzkar())),
              ),
              SizedBox(height: 20,),
              NiceButton(
                radius: 40,
                padding: const EdgeInsets.all(15),
                text: "sleepingAzkar".tr().toString(),
                gradientColors: [secondColor, firstColor],
                onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => SleepingAzkar())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
