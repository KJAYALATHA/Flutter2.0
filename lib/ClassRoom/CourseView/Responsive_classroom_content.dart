import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/ClassRoom/CourseView/desktop_classroom/desktop_CourseView.dart';
import 'package:flutter_app_newocean/ClassRoom/CourseView/navigateTest.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveClassRoomContent extends StatefulWidget {
  @override
  _ResponsiveClassRoomContentState createState() =>
      _ResponsiveClassRoomContentState();
}

class _ResponsiveClassRoomContentState
    extends State<ResponsiveClassRoomContent> {
  final valueController = Get.find<ValueListener>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valueController.navebars.value = "Login";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: ScreenTypeLayout(
        mobile: CoursesView(),
        tablet: CoursesView(),
        desktop: CoursesView(),
      ),
    );
  }
}
