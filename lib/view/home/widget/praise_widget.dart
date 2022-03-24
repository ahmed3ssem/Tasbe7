import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seb7a/helper/db_helper.dart';
import 'package:seb7a/utils/app_colors.dart';
import 'package:seb7a/view/praise.dart';
import 'package:seb7a/widgets/show_message.dart';

class PraiseWidget extends StatelessWidget {

  final TextEditingController praiseNameController = new TextEditingController();
  int id;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          //title: Text('TextField in Dialog'),
          content: SingleChildScrollView(
            child: Container(
              height: ScreenUtil().setHeight(55),
              width: MediaQuery.of(context).size.width,
              margin:  EdgeInsets.only(right: ScreenUtil().setWidth(10) , left: ScreenUtil().setWidth(10)),
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
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
              child: InkWell(
                child: Text('dialogAddButton'.tr().toString() , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 16.sp , color: AppColors.black),),
                onTap: () {
                  if(praiseNameController.value.text.toString().isEmpty){
                    ToastMessage.showMessage('dialogMissingDataError'.tr().toString(), AppColors.red);
                  } else {
                    DBHelper.addPraise('praise_table', {
                      'praiseName': praiseNameController.value.text.toString(),
                      'praiseValue': 0
                    }).then((value) {
                      id = value[0]['id'];
                      print('success');
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Praise(praiseNameController.value.text.toString(), 0 , id)));
                      praiseNameController.clear();
                    }).catchError((error) => print(error));
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
              child: InkWell(
                  child: Text('dialogCancleButton'.tr().toString() , style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 16.sp , color: Colors.red),),
                  onTap: ()=>Navigator.pop(context)
              ),
            ),
          ],
        )
    );
  }
}
