import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:seb7a/presenter/home/home_prsenter_componant.dart';
import 'package:seb7a/view/home/home_view_componant.dart';
import 'package:seb7a/view/home/widget/rating_widget.dart';
import 'package:seb7a/view/home/widget/setting_widget.dart';
import 'package:share/share.dart';

class HomePrsenter implements HomePrsenterComponant{

  HomeViewComponant componant;

  @override
  void setView(HomeViewComponant view) {
    // TODO: implement setView
    componant = view;
  }

  @override
  Future<void> launchURL() async{
    // TODO: implement launchURL
    final Email email = Email(
      subject: 'Tasabee7 Suggestions',
      recipients: ['a7med.assem@gmail.com'],
      isHTML: false,
    );
    await FlutterEmailSender.send(email);
  }

  @override
  void shareApplication() {
    // TODO: implement shareApplication
    Share.share('https://play.google.com/store/apps/details?id=com.assem.tasabeh');
  }

  @override
  onSelectedItem(BuildContext context, int item) {
    // TODO: implement onSelectedItem
    switch (item) {
      case 0:
        SettingWidget widget = SettingWidget();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return widget;
          },
        );
        break;
      case 1:
        shareApplication();
        break;
      case 2:
        launchURL();
        break;
      case 3:
        RatingWidget widget = RatingWidget();
        showDialog(
          context: context,
          builder: (context) => widget,
        );
    }
  }
}