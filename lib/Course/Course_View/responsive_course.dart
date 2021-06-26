import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Course/Course_View/desktop_course.dart';
import 'package:flutter_app_newocean/Menu/Menu_DeskTop.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveCourse extends StatefulWidget {
  @override
  _ResponsiveCourseState createState() => _ResponsiveCourseState();
}

class _ResponsiveCourseState extends State<ResponsiveCourse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menu.updateAll((key, value) => menu[key] = false);
    menu['Courses'] = true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: DesktopCourse(),
      mobile: DesktopCourse(),
      tablet: DesktopCourse(),
    );
  }
}
