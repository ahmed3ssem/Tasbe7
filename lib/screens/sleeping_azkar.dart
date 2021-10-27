import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:seb7a/widgets/azkar_Item_widget.dart';

class SleepingAzkar extends StatefulWidget {

  @override
  _SleepingAzkarState createState() => _SleepingAzkarState();
}

class _SleepingAzkarState extends State<SleepingAzkar> {

  List sleepingAzkar = [];

  Future<void> loadData() async {
    var data = await rootBundle.loadString('resources/sleeping_azkar.json');
    setState(() => sleepingAzkar = json.decode(data));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sleepingAzkar'.tr().toString()),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/image/bg.jpeg'), fit: BoxFit.fill,),
          //shape: BoxShape.circle,
        ),
        child: ListView.builder(physics:BouncingScrollPhysics() , itemCount: sleepingAzkar.length , itemBuilder: (ctx , pos){
          return AzkarItem(description: sleepingAzkar[pos]['name'],value: sleepingAzkar[pos]['benefit'],number: sleepingAzkar[pos]['number']);
        }),
      ),
    );
  }
}
