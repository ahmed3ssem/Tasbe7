import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seb7a/utils/app_colors.dart';
import 'package:seb7a/view/praise_competition.dart';
import 'package:seb7a/widgets/show_message.dart';

class PraiseChallengeWidget extends StatelessWidget {
  final TextEditingController praiseNameController = new TextEditingController();
  final TextEditingController praiseValueController = new TextEditingController();
  final RegExp numberRegExp = new RegExp("^[0-9]*\$");

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))
          ),
          //title: Text('TextField in Dialog'),
          content: Container(
            height: ScreenUtil().setHeight(115),
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
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
              child: InkWell(
                child: Text('dialogAddButton'.tr().toString() , style: TextStyle(fontWeight: FontWeight.w500 , fontSize: 16.sp , color: AppColors.black),),
                onTap: () {
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
            ),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
              child: InkWell(
                child: Text('dialogCancleButton'.tr().toString() , style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 16.sp , color: Colors.red),),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )
    );
  }
}
