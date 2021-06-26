import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Footer/desktop_footer_lg.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/how_it_works.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/main_badget_widget.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/our_client.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/placement_company.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/reviews.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/slider_widget.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/upcoming_course_widget.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/what_is_new.dart';
import 'package:flutter_app_newocean/Menu/Menu_DeskTop.dart';
import 'package:flutter_app_newocean/alert/alert_msg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_newocean/Home/Views/Tablet_home.dart';

class DesktopHome extends StatefulWidget {
  @override
  _DesktopHomeState createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  ScrollController controller = ScrollController();
  final keyIsFirstLoaded = 'is_first_loaded';
  String fullNameAlert;
  String phoneNumberAlert;
  String emailAlert;
  bool flag = true;

  Widget _getChild() {
    return ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SliderWidget(),
            MainBadgeWidget(),
            UpcomingCourse(),
            PlacementCompany(),
            ReviewsSection(),
            OurClient(),
            WhatIsNew(),
            HowItWorks(),
            DesktopFooterLg()
          ],
        );
      },
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    menu.updateAll((key, value) => menu[key] = false);
    menu['Home'] = true;
    //Navbar.visiblity = true;
    Future.delayed(
        Duration(milliseconds: 3000), () => showDialogIfFirstLoaded(context));
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth < 1240) {
        return TabletHome();
      } else {
        return _getChild();
      }
    });
  }

  Future showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);

    //TODO make as isFirstLoaded == null
    if (isFirstLoaded == true) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertEnquiry(
            keyIsFirstLoaded: keyIsFirstLoaded,
          );
        },
      );
    }
  }
}
