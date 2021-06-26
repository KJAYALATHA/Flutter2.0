import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/how_it_works.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/tab_widget/main_badget_widget.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/tab_widget/our_client.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/tab_widget/slider_widget.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/tab_widget/what_is_new.dart';
import 'package:flutter_app_newocean/Menu/Menu_DeskTop.dart';
import 'package:flutter_app_newocean/alert/bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_newocean/Home/TabletHome_widgets/tablet_upcoming_course.dart';
import 'package:flutter_app_newocean/Home/TabletHome_widgets/tablet_placement_company.dart';
import 'package:flutter_app_newocean/Home/TabletHome_widgets/tablet_reviews.dart';
import '../../Footer/tablet_footer.dart';
import 'package:smooth_scroll_web/smooth_scroll_web.dart';

class TabletHome extends StatefulWidget {
  @override
  _TabletHomeState createState() => _TabletHomeState();
}

class _TabletHomeState extends State<TabletHome> {
  ScrollController controller = ScrollController();
  final keyIsFirstLoaded = 'is_first_loaded';
  String fullNameAlert;
  String phoneNumberAlert;
  String emailAlert;
  bool flag = true;
  // Timer _timer;

  void initState() {
    // TODO: implement initState
    super.initState();
    // Navbar.visiblity = true;
    menu.updateAll((key, value) => menu[key] = false);
    menu['Home'] = true;
    Future.delayed(
        Duration(seconds: 3), () => showDialogIfFirstLoaded(context));
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SmoothScrollWeb(
        scrollSpeed: 1000, controller: controller, child: _getChild());
  }

  Future showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);

    //TODO make as isFirstLoaded == null
    if (isFirstLoaded == true) {
      showCupertinoModalPopup(
        barrierColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return MobileBottomSheet(
            keyIsFirstLoaded: keyIsFirstLoaded,
          );
        },
      );
    }
  }

  Widget _getChild() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: 1,
        controller: controller,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SliderWidget(),
              MainBadgeWidget(),
              TabletUpcomingCourse(),
              TabletPlacementCompany(),
              TabletReviewsSection(),
              OurClient(),
              WhatIsNew(),
              HowItWorks(),
              TabletFooter(),
            ],
          );
        },
      ),
    );
  }
}
