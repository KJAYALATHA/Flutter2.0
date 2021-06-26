import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Zoom_integration/Desktop_zoom.dart';
import 'package:responsive_builder/responsive_builder.dart';

// ignore: must_be_immutable
class ResponsiveZoomLink extends StatelessWidget {
  ResponsiveZoomLink({this.zoomLink});
  String zoomLink;
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: DesktopZoomIntegration(
        zoomLink: zoomLink,
      ),
      desktop: DesktopZoomIntegration(
        zoomLink: zoomLink,
      ),
      tablet: DesktopZoomIntegration(
        zoomLink: zoomLink,
      ),
    );
  }
}
