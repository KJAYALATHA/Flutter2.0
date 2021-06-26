import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Career/career/Mobile_Career/mobile_career.dart';
import 'package:flutter_app_newocean/Career/career/Tab_Career/tab_career.dart';
import 'package:flutter_app_newocean/Career/career/career_lg.dart';
import 'package:flutter_app_newocean/Career/career/career_md.dart';
import 'package:flutter_app_newocean/Career/career/career_sm.dart';
import 'package:flutter_app_newocean/Menu/Menu_DeskTop.dart';

class CareerLayout extends StatefulWidget {
  static final emailController = TextEditingController();

  @override
  _CareerLayoutState createState() => _CareerLayoutState();
}

class _CareerLayoutState extends State<CareerLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menu.updateAll((key, value) => menu[key] = false);
    menu['Career'] = true;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: missing_return
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 1600) {
        return CareerLg();
      } else if (constraints.maxWidth > 1300 && constraints.maxWidth < 1601) {
        return CareerMd();
      } else if (constraints.maxWidth > 900 && constraints.maxWidth < 1301) {
        return CareerSm();
      } else if (constraints.maxWidth > 600 && constraints.maxWidth < 901) {
        return TabCareer();
      } else if (constraints.maxWidth > 300 && constraints.maxWidth < 601) {
        return MobileCareer();
      }
    });
  }
}
