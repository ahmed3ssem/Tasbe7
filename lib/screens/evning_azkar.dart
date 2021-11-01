import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/services.dart';
import 'package:seb7a/utils/common.dart';
import 'package:share/share.dart';


class EvningAzkar extends StatefulWidget {
  const EvningAzkar({Key key}) : super(key: key);

  @override
  _EvningAzkarState createState() => _EvningAzkarState();
}

class _EvningAzkarState extends State<EvningAzkar> {

  List evningAzkar = [];

  Future<void> loadData() async {
    var data = await rootBundle.loadString('resources/evning_azkar.json');
    setState(() => evningAzkar = json.decode(data));
  }

  @override
  void initState() {
    super.initState();
    this.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EvningAzkar'.tr().toString()),
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
        child: ListView.builder(physics:BouncingScrollPhysics() , itemCount: evningAzkar.length , itemBuilder: (ctx , pos){
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
                        Text(evningAzkar[pos]['name'] , style: TextStyle(fontWeight: FontWeight.bold , fontSize: Common.fontSize),),
                        SizedBox(height: 8,),
                        Text(evningAzkar[pos]['benefit'] , style: TextStyle(fontSize: Common.fontSize),)
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
                              child: Text(evningAzkar[pos]['number'], style: TextStyle(fontSize: Common.fontSize),),
                            ),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          Share.share('الذكر:'+"\n"+evningAzkar[pos]['name']+"\n"+evningAzkar[pos]['benefit']+"\n"+"عدد المرات= "+evningAzkar[pos]['number']);
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
                int number = int.parse(evningAzkar[pos]['number']);
                if(number>=1){
                  setState(() {
                    number--;
                    evningAzkar[pos]['number'] = number.toString();
                  });
                }
                if(number == 0){
                  setState(() {
                    evningAzkar.removeAt(pos);
                  });
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
