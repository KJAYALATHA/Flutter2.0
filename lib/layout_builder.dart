import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/ClassRoom/CourseView/bottom_navigation.dart';
import 'package:flutter_app_newocean/Landing/Home_view.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/Webinar/flash_notification.dart';
import 'package:flutter_app_newocean/all_end_drawer.dart';
import 'package:flutter_app_newocean/all_menubar.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'route/navigation_locator.dart';
import 'route/navigation_service.dart';
import 'route/routeNames.dart';

import 'package:flutter_app_newocean/main.dart';

Map bottom = {
  'My Course': true,
  'All Course': false,
  'Settings': false,
};

// ignore: must_be_immutable
class MainLayout extends StatefulWidget {
  // static bool sticNotification = true;
  bool notification = true;
  MainLayout({this.child, this.menubar});
  Widget child;
  Widget menubar;

  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  bool isWebinar = true;
  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginResponsive.registerNumber = (prefs.getString('user') ?? null);
    print("layout_builder session ${LoginResponsive.registerNumber}");
  }

  final valueController = Get.find<ValueListener>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      return Scaffold(
        key: scaffoldKey,
        // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        // floatingActionButton: sizingInformation.deviceScreenType ==
        //         DeviceScreenType.desktop
        //     ? null
        //     : FloatingActionButton(
        //         backgroundColor: Colors.white,
        //         child: Icon(
        //           Icons.ondemand_video_rounded,
        //           color: Colors.red,
        //         ),
        //         onPressed: () {
        //           locator<NavigationService>().navigateTo(UpcomingWebinarRoute);
        //         },
        //       ),
        endDrawer: Obx(() {
          if (valueController.navebars.value == 'Login') {
            return AllEndDrawer();
          } else {
            return SizedBox();
          }
        }),
        extendBodyBehindAppBar: true,
        // drawer: MenuBarDrawer(),
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.desktop
            ? MediaQuery.of(context).size.width < 1240
                ? AllDrawer()
                : null
            : AllDrawer(),
        bottomNavigationBar: Obx(() {
          if (valueController.navebars.value == 'Login') {
            return MediaQuery.of(context).size.width < 1240
                ? Container(
                    height: 50,
                    color: Colors.grey,
                    child: Row(
                      children: [
                        ClassRoomBottomNavigationBar(
                          iconName: 'My Course',
                          icon: Icons.add,
                          color: bottom['My Course']
                              ? Colors.blue[800]
                              : Colors.blue,
                          onTap: () {
                            setState(() {
                              bottom.updateAll((key, value) => false);
                              bottom['My Course'] = true;
                            });
                            locator<NavigationService>().navigateTo(
                                '/ClassRoom?userNumber=${LoginResponsive.registerNumber}&typeOfCourse=${valueController.courseType.value}');
                            print(valueController.courseType.value);
                            valueController.courseType.value = 'My Course';
                          },
                        ),
                        ClassRoomBottomNavigationBar(
                          iconName: 'All Course',
                          icon: Icons.add,
                          color: bottom['All Course']
                              ? Colors.blue[800]
                              : Colors.blue,
                          onTap: () {
                            setState(() {
                              bottom.updateAll((key, value) => false);
                              bottom['All Course'] = true;
                            });
                            locator<NavigationService>().navigateTo(
                                '/ClassRoom?userNumber=${LoginResponsive.registerNumber}&typeOfCourse=${valueController.courseType.value}');
                            print(valueController.courseType.value);
                            valueController.courseType.value = 'All Course';

                            print('tap');
                          },
                        ),
                      ],
                    ),
                  )
                : SizedBox();
          } else {
            return SizedBox();
          }
        }),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                sizingInformation.deviceScreenType == DeviceScreenType.desktop
                    ? Obx(() {
                        return Visibility(
                          visible: valueController.isFlashNotification.value,
                          child: FlashNotification(
                            dismissNotification: () {
                              valueController.isFlashNotification.value = false;
                            },
                          ),
                        );
                      })
                    : SizedBox(),
                widget.menubar,
                // ResponsiveLoginMenu(),
                sizingInformation.deviceScreenType == DeviceScreenType.desktop
                    ? SizedBox()
                    : Obx(() {
                        if (valueController.isFlashNotification.value) {
                          return Dismissible(
                            key: Key('webinar'),
                            background: Container(
                              color: Colors.blue,
                              height: 10,
                            ),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Free Webinar',
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.red),
                                  ),
                                ],
                              ),
                              leading: IconButton(
                                icon: Icon(Icons.video_collection_outlined),
                                color: Colors.red,
                                onPressed: () {
                                  valueController.isFlashNotification.value =
                                      false;
                                  locator<NavigationService>()
                                      .navigateTo(UpcomingWebinarRoute);
                                },
                              ),
                              trailing: Icon(
                                Icons.swipe,
                                color: Colors.blue,
                              ),
                            ),
                            onDismissed: (deirection) {
                              valueController.isFlashNotification.value = false;
                            },
                          );
                        } else {
                          return SizedBox();
                        }
                      }),

                Expanded(child: widget.child),
              ],
            ),
          ),
        ),
      );
    });
  }
}
