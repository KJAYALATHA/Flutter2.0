import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Login_Menubar/LoginMenuView/desktop_login_menu.dart';
import 'package:flutter_app_newocean/Login_Menubar/LoginMenuView/mobile_login_menu.dart';
import 'package:flutter_app_newocean/Login_Menubar/LoginMenuView/tablet_login_menu.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveLoginMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileLoginMenu(),
      desktop: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 1241) {
            return TabletLoginMenu();
          } else {
            return DesktopLoginMenu();
          }
        },
      ),
      tablet: TabletLoginMenu(),
    );
  }
}
