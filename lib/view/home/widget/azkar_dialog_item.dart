import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarDialogItem extends StatelessWidget {

  final String title;
  final VoidCallback onTap;

  AzkarDialogItem(this.title, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(5) , bottom: ScreenUtil().setHeight(5), right: ScreenUtil().setWidth(20) , left: ScreenUtil().setWidth(20)),
          child: Text(title, style: TextStyle(fontWeight: FontWeight.w400 , color: Colors.white , fontSize: 20.sp),),
        ),
      ),
    );
  }
}
