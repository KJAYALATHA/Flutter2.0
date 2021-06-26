import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Landing/Home_view.dart';
import 'package:flutter_app_newocean/Login_Menubar/Login_Endrawer/profile_items.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';

class WebinarEndDrawer extends StatefulWidget {
  @override
  _WebinarEndDrawerState createState() => _WebinarEndDrawerState();
}

class _WebinarEndDrawerState extends State<WebinarEndDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      color: Colors.pink,
      child: Column(
        children: [
          Container(
            height: 200,
          ),
          ProfileItems(
            textColor: Colors.grey[600],
            iconColor: Colors.grey[600],
            icon: Icons.phone,
            label: 'Contact Us',
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
              locator<NavigationService>().navigateTo(ContactUsRoute);
            },
          ),
        ],
      ),
    );
  }
}
