import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_newocean/Webinar/WebinarCard_Desktop/webinar_const.dart';
import 'package:flutter_app_newocean/common/constants.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:flutter_app_newocean/ocean_icon/ocean_icons.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'package:get/get.dart';

class DesktopWebinarMenubar extends StatelessWidget {
  final valueController = Get.find<ValueListener>();
  @override
  Widget build(BuildContext context) {
    //print("webinar login checking${MenuBar.stayUser}");
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 80,
      decoration: BoxDecoration(color: Colors.grey[100], boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, -4)),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: GestureDetector(
              onTap: () {
                valueController.isFlashNotification.value = true;
                valueController.navebars.value = 'Home';
                locator<NavigationService>().navigateTo(HomeRoute);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Ocean.oa,
                    size: 60,
                    color: Colors.blue,
                  ),
                  Text(
                    'ocean academy',
                    style: TextStyle(
                        fontFamily: 'Ubuntu',
                        inherit: false,
                        fontSize: 35,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            width: 400,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      child: Text(
                        'CONTACT',
                        style: TextStyle(
                            color: kBlue,
                            fontSize: 20,
                            fontFamily: kfontname,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      valueController.isFlashNotification.value = true;
                      valueController.navebars.value = 'Home';
                      locator<NavigationService>().navigateTo(LoginRoute);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: kBlue, width: 3),
                          borderRadius: BorderRadius.circular(100)),
                      child: Text(
                        'LOG IN',
                        style: TextStyle(
                            color: kBlue,
                            fontSize: 20,
                            fontFamily: kfontname,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
