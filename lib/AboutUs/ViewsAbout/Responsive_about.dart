import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/AboutUs/ViewsAbout/destop_aboutus.dart';
import 'package:flutter_app_newocean/AboutUs/ViewsAbout/mobile_aboutus.dart';
import 'package:flutter_app_newocean/AboutUs/ViewsAbout/tablet_aboutus.dart';
import 'package:flutter_app_newocean/Menu/Menu_DeskTop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveAboutUs extends StatefulWidget {
  @override
  _ResponsiveAboutUsState createState() => _ResponsiveAboutUsState();
}

class _ResponsiveAboutUsState extends State<ResponsiveAboutUs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menu.updateAll((key, value) => menu[key] = false);
    menu['About Us'] = true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileAboutUs(),
      tablet: TabletAboutUs(),
      desktop: DesktopAboutUs(),
    );
  }
}
