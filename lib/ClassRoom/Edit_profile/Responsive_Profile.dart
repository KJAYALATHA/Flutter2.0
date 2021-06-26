import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/ClassRoom/Edit_profile/desktop_edit_profile.dart';
import 'package:flutter_app_newocean/ClassRoom/Edit_profile/mobile_edit_profile.dart';
import 'package:flutter_app_newocean/ClassRoom/Edit_profile/tablet_edit_profile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveEditProfile extends StatefulWidget {
  String userNumber;
  ResponsiveEditProfile({this.userNumber});
  @override
  _ResponsiveEditProfileState createState() => _ResponsiveEditProfileState();
}

class _ResponsiveEditProfileState extends State<ResponsiveEditProfile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileEditProfile(),
      tablet: TabletEditProfile(),
      desktop: DesktopEditProfile(),
    );
  }
}
