import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Landing/Home_view.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/Login_Menubar/Login_Endrawer/profile_items.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DesktopEndDrawer extends StatefulWidget {
  @override
  _DesktopEndDrawerState createState() => _DesktopEndDrawerState();
}

class _DesktopEndDrawerState extends State<DesktopEndDrawer> {
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
    print(valueController.isFlashNotification.value);
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: valueController.isFlashNotification.value ? 165 : 100),
      width: 450,
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            //height: 300,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileItems(
                  textColor: Colors.grey[600],
                  iconColor: Colors.grey[600],
                  topRadius: 10,
                  icon: Icons.palette,
                  label: 'Edit Profile',
                  onPressed: () {
                    scaffoldKey.currentState.openDrawer();
                    locator<NavigationService>().navigateTo(
                        "/Profile?id=${LoginResponsive.registerNumber}");
                  },
                ),
                ProfileItems(
                  textColor: Colors.grey[600],
                  iconColor: Colors.grey[600],
                  icon: Icons.palette,
                  label: 'Certificate',
                  onPressed: () {
                    scaffoldKey.currentState.openDrawer();
                    locator<NavigationService>().navigateTo(
                        "/Certificate?id=${LoginResponsive.registerNumber}");
                  },
                ),
                ProfileItems(
                  textColor: Colors.grey[600],
                  iconColor: Colors.grey[600],
                  icon: Icons.palette,
                  label: 'Purchase',
                  onPressed: () {
                    scaffoldKey.currentState.openDrawer();
                    locator<NavigationService>().navigateTo(
                        "/Purchase?id=${LoginResponsive.registerNumber}");
                  },
                ),
                ProfileItems(
                  textColor: Colors.grey[600],
                  iconColor: Colors.grey[600],
                  icon: Icons.palette,
                  bottonRadius: 10,
                  label: 'LogOut',
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    await prefs.setString('user', null);
                    LoginResponsive.registerNumber = null;
                    scaffoldKey.currentState.openDrawer();
                    locator<NavigationService>().navigateTo(HomeRoute);
                    valueController.navebars.value = 'Home';
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
