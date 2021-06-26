import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Login/Login_View/log_in.dart';
import 'package:flutter_app_newocean/Login/Login_View/mobile-login.dart';

import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginResponsive extends StatefulWidget {
  // static bool isLogin = false;
  static ConfirmationResult confirmationResult;
  static String registerNumber;
  static bool isLogin = false;

  @override
  _LoginResponsiveState createState() => _LoginResponsiveState();
}

class _LoginResponsiveState extends State<LoginResponsive> {
  final valueController = Get.find<ValueListener>();
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: LogIn(),
      tablet: LogIn(),
      mobile: MobileLogin(),
    );
  }
}
