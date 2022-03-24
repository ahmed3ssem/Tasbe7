import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seb7a/helper/save_offline.dart';
import 'package:seb7a/utils/app_colors.dart';
import 'package:seb7a/utils/common.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({Key key}) : super(key: key);

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("setting".tr().toString()),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: SingleChildScrollView(
                child: Container(
                  height: ScreenUtil().setHeight(195),
                  width: MediaQuery.of(context).size.width,
                  margin:  EdgeInsets.only(right: ScreenUtil().setWidth(10) , left: ScreenUtil().setWidth(10)),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: ScreenUtil().setWidth(12)),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('fontSize'.tr().toString() , style: TextStyle(color: AppColors.black , fontSize: 15.sp),),
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
                      SizedBox(height: ScreenUtil().setHeight(15),),
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
                                style: TextStyle(fontSize: 15.0.sp),
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
                                style: TextStyle(fontSize: 15.0.sp),
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
        )
    );
  }
}
