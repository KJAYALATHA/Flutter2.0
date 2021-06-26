import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_newocean/Landing/Home_view.dart';
import 'package:flutter_app_newocean/Menu/Menu_DeskTop.dart';
import 'package:flutter_app_newocean/getx_controller.dart';

import 'package:flutter_app_newocean/ocean_icon/ocean_icons.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'package:get/get.dart';

import '../route/routeNames.dart';

class MenuBarDrawer extends StatefulWidget {
  @override
  _MenuBarDrawerState createState() => _MenuBarDrawerState();
}

class _MenuBarDrawerState extends State<MenuBarDrawer> {
  final valueController = Get.find<ValueListener>();

  @override
  Widget build(BuildContext context) {
    final state = RootDrawer.of(context);
    return Drawer(
      child: Container(
        width: 250,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //   child: Image.asset('images/alert.png'),
            // ),
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
            Expanded(
                child: Column(
              children: [
                menuItem(
                    icon: Icons.home, text: 'Home', naviagationPath: HomeRoute),
                menuItem(
                    icon: Icons.info,
                    text: 'About Us',
                    naviagationPath: AboutRoute),
                menuItem(
                    icon: Icons.miscellaneous_services_rounded,
                    text: 'Services',
                    naviagationPath: ServiceRoute),
                menuItem(
                    icon: Icons.book_rounded,
                    text: 'Courses',
                    naviagationPath: CourseRoute),
                menuItem(
                    icon: Icons.contact_page_outlined,
                    text: 'Contact Us',
                    naviagationPath: ContactUsRoute),
                menuItem(
                    icon: Icons.bar_chart,
                    text: 'Career',
                    naviagationPath: CareerRoute),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Row(
                        children: [
                          Icon(
                            Icons.login,
                            color: Colors.blue,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      locator<NavigationService>().navigateTo(LoginRoute);
                      state.close();

                      ///todo named parameter routing
                    },
                  ),
                ),
              ],
            )),

            Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined),
                color: Colors.grey[700],
                onPressed: () {
                  scaffoldKey.currentState.openEndDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  MouseRegion menuItem({IconData icon, text, widget, naviagationPath}) {
    final state = RootDrawer.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Icon(
                icon,
                color: menu[text] ? Colors.blue : Colors.grey[500],
              ),
              SizedBox(width: 10),
              Text(
                text,
                style: TextStyle(
                  color: menu[text] ? Colors.blue : Colors.grey[500],
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            menu.updateAll((key, value) => menu[key] = false);
            menu[text] = true;
          });
          locator<NavigationService>().navigateTo(naviagationPath);

          ///todo named parameter routing
          print(text);
          // Navigator.of(context).pop();
          valueController.isFlashNotification.value = true;
          valueController.navebars.value = 'Home';
          state.close();
          // scaffoldKey.currentState.openEndDrawer();
        },
      ),
    );
  }
}

class RootDrawer {
  static DrawerControllerState of(BuildContext context) {
    final DrawerControllerState drawerControllerState =
        context.findRootAncestorStateOfType();
    return drawerControllerState;
  }
}

class RootScaffold {
  static openDrawer(BuildContext context) {
    final ScaffoldState scaffoldState = context.findRootAncestorStateOfType();
    scaffoldState.openDrawer();
  }

  static ScaffoldState of(BuildContext context) {
    final ScaffoldState scaffoldState = context.findRootAncestorStateOfType();
    return scaffoldState;
  }
}
