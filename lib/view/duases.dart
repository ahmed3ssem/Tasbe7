import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:seb7a/view/propheticprayers.dart';
import 'package:seb7a/view/quran_prayers.dart';



class Duases extends StatefulWidget {

  @override
  _DuasesState createState() => _DuasesState();
}

class _DuasesState extends State<Duases> with TickerProviderStateMixin{
  TabController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: 2 , vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          tabs: [
            Tab(child: Text('propheticPrayers'.tr().toString() , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),),
            Tab(child: Text('quranPrayers'.tr().toString(), style: TextStyle(fontWeight: FontWeight.bold , fontSize: 22),),),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          PropheticPrayers(),
          QuranPrayers(),
        ],
      ),
    );
  }
}
