import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child:  RatingDialog(
          // your app's name?
          title: Text('rateUsDialogTitle'.tr().toString()),
          // encourage your user to leave a high rating?
          message:
          Text('rateUsDialogMessage'.tr().toString()),
          // your app's logo?
          image:  Image.asset('assets/image/appicon.jpeg',width: ScreenUtil().setWidth(50),height: ScreenUtil().setHeight(50),),
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
        )
    );
  }
}
