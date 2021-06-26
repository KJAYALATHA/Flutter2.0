import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/payment/desktop_payment.dart';
import 'package:flutter_app_newocean/payment/mobile_payment.dart';
import 'package:flutter_app_newocean/payment/tablet_payment.dart';
import 'package:responsive_builder/responsive_builder.dart';

// ignore: must_be_immutable
class ResponsivePayment extends StatelessWidget {
  String courseName;
  String amount;
  List course;
  String courseImage;
  String batchid;

  ResponsivePayment(
      {this.amount,
      this.course,
      this.courseName,
      this.courseImage,
      this.batchid});
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileRazorPay(
        courseName: courseName,
        courseImage: courseImage,
        course: [courseName],
        batchid: [batchid],
        amount: amount,
      ),
      desktop: RazorPayWeb(
        course: [courseName],
        amount: amount,
        batchid: [batchid],
        courseImage: courseImage,
        courseName: courseName,
      ),
      tablet: TabletRazorPay(
        amount: amount,
        batchid: [batchid],
        course: [courseName],
        courseImage: courseImage,
        courseName: courseName,
      ),
    );
  }
}
