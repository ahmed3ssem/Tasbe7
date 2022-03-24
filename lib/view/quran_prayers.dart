import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seb7a/helper/save_offline.dart';
import 'package:seb7a/utils/common.dart';

class QuranPrayers extends StatefulWidget {

  @override
  _QuranPrayersState createState() => _QuranPrayersState();
}

class _QuranPrayersState extends State<QuranPrayers> {

  List quranprayer = [];

  Future<void> loadData() async {
    var data = await rootBundle.loadString('resources/quran_prayers.json');
    setState(() => quranprayer = json.decode(data));
    SaveOffline.isFirstTimeUpdate().then((value){
      if(!value){
        firstTimeDialog();
      }
    });
  }

  void firstTimeDialog() async {
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
              height: 130,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(right: 10 , left: 10),
              child: Text('azkarDialogText'.tr().toString()),
            ),
          ),
          actions: <Widget>[
            FlatButton(
                child: Text('ok'.tr().toString() , style: TextStyle(color: Colors.green),),
                onPressed: (){
                  SaveOffline.firstTimeUpdate();
                  Navigator.pop(context);
                }
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    this.loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/bg.jpeg'), fit: BoxFit.fill,),
        //shape: BoxShape.circle,
      ),
      child: ListView.builder(physics:BouncingScrollPhysics() , itemCount: quranprayer.length , itemBuilder: (ctx , pos){
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(15.0) //                 <--- border radius here
              ),
              color: Colors.blue
          ),
          child: InkWell(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  //margin: const EdgeInsets.all(1),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                          Radius.circular(15.0) //                 <--- border radius here
                      ),
                      color: Colors.white
                  ),
                  child: Column(
                    children: [
                      Text(quranprayer[pos]['name'] , style: TextStyle(fontWeight: FontWeight.bold , fontSize: Common.fontSize),),
                      SizedBox(height: 8,),
                      Text(quranprayer[pos]['benefit'] , style: TextStyle(fontSize: Common.fontSize),)
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text("repeat".tr().toString(), style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),),
                        SizedBox(width: 5,),
                        Container(
                          width: Common.fontSize >20 ?60 : 40,
                          height: Common.fontSize >20 ?60 : 40,
                          child: Center(
                            child: Text(quranprayer[pos]['number'], style: TextStyle(fontSize: Common.fontSize),),
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        Share.share('الذكر:'+"\n"+quranprayer[pos]['name']+"\n"+quranprayer[pos]['benefit']+"\n"+"عدد المرات= "+quranprayer[pos]['number']);
                      },
                      child: Row(
                        children: [
                          Text("share".tr().toString(), style: TextStyle(fontWeight: FontWeight.bold , color: Colors.white),),
                          SizedBox(width: 2,),
                          IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.share , color: Colors.white,))
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 6,)
              ],
            ),
            onTap: (){
              int number = int.parse(quranprayer[pos]['number']);
              if(number>=1){
                setState(() {
                  number--;
                  quranprayer[pos]['number'] = number.toString();
                });
              }
              if(number == 0){
                setState(() {
                  quranprayer.removeAt(pos);
                });
              }
            },
          ),
        );
      }),
    );
  }
}
