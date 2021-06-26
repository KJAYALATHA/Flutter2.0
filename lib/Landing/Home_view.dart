import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/Views/Tablet_home.dart';
import 'package:flutter_app_newocean/Home/Views/desktop_home.dart';
import 'package:flutter_app_newocean/Home/Views/mobile_home.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileHome(),
      tablet: TabletHome(),
      desktop: DesktopHome(),
    );
  }
}
