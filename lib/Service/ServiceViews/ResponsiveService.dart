import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Menu/Menu_DeskTop.dart';
import 'package:flutter_app_newocean/Service/ServiceViews/desktop_service.dart';
import 'package:flutter_app_newocean/Service/ServiceViews/tab_service.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveService extends StatefulWidget {
  @override
  _ResponsiveServiceState createState() => _ResponsiveServiceState();
}

class _ResponsiveServiceState extends State<ResponsiveService> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menu.updateAll((key, value) => menu[key] = false);
    menu['Services'] = true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: TabService(),
      desktop: DesktopService(),
      tablet: TabService(),
    );
  }
}
