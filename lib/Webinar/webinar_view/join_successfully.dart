import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Webinar/WebinarCard_Desktop/join_successfully.dart';
import 'package:flutter_app_newocean/Webinar/mobile_wbinar/mobile_join_successfuly.dart';
import 'package:responsive_builder/responsive_builder.dart';

// ignore: must_be_immutable
class ResponsiveWebinarJoinSuccessfully extends StatelessWidget {
  ResponsiveWebinarJoinSuccessfully({this.userName});
  String userName;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileJoinSuccessfully(
        joinUserName: userName,
      ),
      desktop: JoinSuccessfully(
        joinUserName: userName,
      ),
      tablet: MobileJoinSuccessfully(
        joinUserName: userName,
      ),
    );
  }
}
