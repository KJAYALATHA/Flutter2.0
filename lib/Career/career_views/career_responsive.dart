import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Career/career_views/career_desktop.dart';
import 'package:flutter_app_newocean/Career/career_views/career_mobile.dart';
import 'package:flutter_app_newocean/Career/career_views/career_tab.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveCareer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: CareerMobile(),
      tablet: CareerTab(),
      desktop: CareerDesktop(),
    );
  }
}
