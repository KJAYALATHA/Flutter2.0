import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Menu/Menubar_drawer.dart';
import '../route/navigation_locator.dart';
import '../route/navigation_service.dart';
import '../route/routeNames.dart';

class MenuBarMobile extends StatefulWidget {
  @override
  _MenuBarMobileState createState() => _MenuBarMobileState();
}

class _MenuBarMobileState extends State<MenuBarMobile> {
  @override
  Widget build(BuildContext context) {
    final state = RootDrawer.of(context);
    return AppBar(
      backgroundColor: Color(0xFFECF5FF),
      leading: IconButton(
        icon: Icon(
          Icons.menu,
          color: Colors.blue,
        ),
        // key: widget.scaffoldKey,
        onPressed: () {
          RootScaffold.openDrawer(context);
        },
      ),
      centerTitle: true,
      title: Image.asset(
        'images/OA.png',
        width: 180,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.ondemand_video_rounded, color: Colors.red),
          onPressed: () {
            locator<NavigationService>().navigateTo(UpcomingWebinarRoute);
          },
        ),
      ],
    );
  }
}
