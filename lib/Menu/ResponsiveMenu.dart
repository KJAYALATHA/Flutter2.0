import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Menu/Menu_DeskTop.dart';
import 'package:flutter_app_newocean/Menu/Menu_Mobile.dart';
import 'package:flutter_app_newocean/Menu/Menu_Tablet.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MenuBarMobile(),
      desktop: MenuBarDesktop(),
      tablet: MenuBarTablet(),
    );
  }
}
