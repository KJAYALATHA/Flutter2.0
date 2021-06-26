import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Webinar/webinar_menubar/desktop_webinar_menu.dart';
import 'package:flutter_app_newocean/Webinar/webinar_menubar/mobile_wbinar_navbar.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveWbinarMenubar extends StatefulWidget {
  @override
  _ResponsiveWbinarMenubarState createState() =>
      _ResponsiveWbinarMenubarState();
}

class _ResponsiveWbinarMenubarState extends State<ResponsiveWbinarMenubar> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: DesktopWebinarMenubar(),
      tablet: MobileWebinarMenubar(),
      mobile: MobileWebinarMenubar(),
    );
  }
}
