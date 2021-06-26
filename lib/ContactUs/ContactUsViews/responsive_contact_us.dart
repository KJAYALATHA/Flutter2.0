import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/ContactUs/desktop_contactus.dart';
import 'package:flutter_app_newocean/ContactUs/mobile_contactus.dart';
import 'package:flutter_app_newocean/ContactUs/tablet_contactus.dart';
import 'package:flutter_app_newocean/Menu/Menu_DeskTop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveContactUs extends StatefulWidget {
  @override
  _ResponsiveContactUsState createState() => _ResponsiveContactUsState();
}

class _ResponsiveContactUsState extends State<ResponsiveContactUs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menu.updateAll((key, value) => menu[key] = false);
    menu['Contact Us'] = true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileContactUs(),
      desktop: DesktopContactUs(),
      tablet: TabletContactUs(),
    );
  }
}
