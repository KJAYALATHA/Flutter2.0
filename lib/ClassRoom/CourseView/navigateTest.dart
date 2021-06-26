import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/ClassRoom/CourseView/my_Course/My_course.dart';

class NavigateTest extends StatefulWidget {
  @override
  _NavigateTestState createState() => _NavigateTestState();
}

class _NavigateTestState extends State<NavigateTest> {
  bool isCourseMode = false;
  int current = 0;
  List tabs = [
    Container(
      child: Text("jaya"),
    ),
    MyCourse(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 577,
      width: 60,
      color: Colors.green,
    );
  }
}

class Testing extends StatefulWidget {
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      color: Colors.green,
    );
  }
}
