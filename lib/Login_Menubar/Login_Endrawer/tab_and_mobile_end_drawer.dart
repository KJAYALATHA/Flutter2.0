import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/Login_Menubar/Login_Endrawer/profile_items.dart';
import 'package:flutter_app_newocean/Menu/Menubar_drawer.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:flutter_app_newocean/ocean_icon/ocean_icons.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TabAndMobileEndDrawer extends StatefulWidget {
  @override
  _TabAndMobileEndDrawerState createState() => _TabAndMobileEndDrawerState();
}

class _TabAndMobileEndDrawerState extends State<TabAndMobileEndDrawer> {
  final valueController = Get.find<ValueListener>();

  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginResponsive.registerNumber = (prefs.getString('user') ?? null);
    print("End_drayer session ${LoginResponsive.registerNumber}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    final state = RootDrawer.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: Colors.white,
      ),
      //height: 300,
      width: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Colors.blue,
            child: Column(
              children: [
                Icon(
                  Ocean.oa,
                  color: Colors.white,
                  size: 50,
                ),
                Text(
                  "Ocean Academy",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15, top: 8),
                  color: Colors.transparent,
                  height: 1,
                )
              ],
            ),
          ),
          ProfileItems(
            textColor: Colors.grey[600],
            iconColor: Colors.grey[600],
            icon: Icons.notifications_active,
            label: 'Notification',
            onPressed: () {
              locator<NavigationService>().navigateTo(
                  "/UserNotification?id=${LoginResponsive.registerNumber}");
              state.close();
            },
          ),
          ProfileItems(
            textColor: Colors.grey[600],
            iconColor: Colors.grey[600],
            icon: Icons.palette,
            label: 'Edit Profile',
            onPressed: () {
              locator<NavigationService>()
                  .navigateTo("/Profile?id=${LoginResponsive.registerNumber}");
              state.close();
            },
          ),
          ProfileItems(
            textColor: Colors.grey[600],
            iconColor: Colors.grey[600],
            icon: Icons.book_rounded,
            label: 'Certificate',
            onPressed: () {
              locator<NavigationService>().navigateTo(
                  "/Certificate?id=${LoginResponsive.registerNumber}");
              state.close();
            },
          ),
          ProfileItems(
            textColor: Colors.grey[600],
            iconColor: Colors.grey[600],
            icon: Icons.badge,
            label: 'Purchase',
            onPressed: () {
              locator<NavigationService>()
                  .navigateTo("/Purchase?id=${LoginResponsive.registerNumber}");
              state.close();
            },
          ),
          ProfileItems(
            textColor: Colors.grey[600],
            iconColor: Colors.grey[600],
            icon: Icons.logout,
            label: 'LogOut',
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();

              await prefs.setString('user', null);
              LoginResponsive.registerNumber = null;

              locator<NavigationService>().navigateTo(HomeRoute);
              valueController.navebars.value = 'Home';
              state.close();
            },
          ),
        ],
      ),
    );
  }
}
