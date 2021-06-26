import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/ClassRoom/User_Notification/desktop_user_notification.dart';
import 'package:flutter_app_newocean/ClassRoom/User_Notification/mobile_user_notification.dart';
import 'package:flutter_app_newocean/ClassRoom/User_Notification/tablet_user_notification.dart';
import 'package:responsive_builder/responsive_builder.dart';

// ignore: must_be_immutable
class ResponsiveUserNotification extends StatefulWidget {
  String userNumber;
  ResponsiveUserNotification({this.userNumber});
  @override
  _ResponsiveUserNotificationState createState() =>
      _ResponsiveUserNotificationState();
}

class _ResponsiveUserNotificationState
    extends State<ResponsiveUserNotification> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileUserNotification(),
      tablet: TabletUserNotification(),
      desktop: DesktopUserNotification(),
    );
  }
}
