import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Webinar/mobile_single%20webinar.dart';

import 'package:flutter_app_newocean/Webinar/single_wbinar.dart';
import 'package:responsive_builder/responsive_builder.dart';

// ignore: must_be_immutable
class ResponsiveWebinar extends StatelessWidget {
  ResponsiveWebinar({this.topic});
  String topic;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileSingleWebinarScreen(
        topic: topic,
      ),
      desktop: SingleWebinarScreen(
        topic: topic,
      ),
      tablet: MobileSingleWebinarScreen(
        topic: topic,
      ),
    );
  }
}
