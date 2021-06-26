import 'package:flutter/material.dart';

import 'package:flutter_app_newocean/Course/course_description/course_details.dart';
import 'package:flutter_app_newocean/Course/course_description/mobile_course_details.dart';
import 'package:responsive_builder/responsive_builder.dart';

// ignore: must_be_immutable
class ResponsiveCourseDetails extends StatelessWidget {
  String courseName;
  String batchId;
  String trainerName;
  String description;
  ResponsiveCourseDetails({
    this.courseName,
    this.trainerName,
    this.description,
    this.batchId,
  });
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: MediaQuery.of(context).size.width > 1177
          ? DesktopCourseDetails(
              batch: batchId,
              course: courseName,
              discription: description,
              trainer: trainerName,
            )
          : MobileCourseDetails(
              batch: batchId,
              course: courseName,
              discription: description,
              trainer: trainerName,
            ),
      mobile: MobileCourseDetails(
        batch: batchId,
        course: courseName,
        discription: description,
        trainer: trainerName,
      ),
      tablet: MobileCourseDetails(
        batch: batchId,
        course: courseName,
        discription: description,
        trainer: trainerName,
      ),
    );
  }
}
