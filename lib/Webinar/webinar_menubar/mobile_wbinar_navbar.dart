import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_newocean/Landing/Home_view.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'package:get/get.dart';

class MobileWebinarMenubar extends StatefulWidget {
  @override
  _MobileWebinarMenubarState createState() => _MobileWebinarMenubarState();
}

class _MobileWebinarMenubarState extends State<MobileWebinarMenubar> {
  final valueController = Get.find<ValueListener>();

  @override
  Widget build(BuildContext context) {
    // valueController.navebars.value = 'Webinar';
    return Container(
      height: 80,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: IconButton(
                icon: Icon(Icons.menu_sharp),
                color: Colors.blue,
                onPressed: () {
                  scaffoldKey.currentState.openDrawer();
                }),
          ),
          Text(
            'Ocean Academy Webinar',
            style: TextStyle(
                fontFamily: 'Ubuntu',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ),
          // Image.asset(
          //   'images/OA.png',
          //   width: 300,
          // ),
          Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    valueController.isFlashNotification.value = true;
                    valueController.navebars.value = 'Home';

                    locator<NavigationService>().navigateTo(ContactUsRoute);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.blue,
                        ),
                        Text(
                          'Contact',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    valueController.isFlashNotification.value = true;
                    LoginResponsive.registerNumber != null
                        ? valueController.navebars.value = 'Login'
                        : valueController.navebars.value = 'Home';
                    locator<NavigationService>().navigateTo(LoginResponsive
                                .registerNumber !=
                            null
                        ? '/ClassRoom?userNumber=${LoginResponsive.registerNumber}typeOfCourse=My%20Course'
                        : LoginRoute);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Icon(
                          Icons.login,
                          color: Colors.blue,
                        ),
                        Text(
                          'Login',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
