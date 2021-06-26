import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_app_newocean/ClassRoom/Certificates/desktop_certificate.dart';
import 'package:flutter_app_newocean/ClassRoom/Certificates/tablet_certificate.dart';
import 'package:flutter_app_newocean/ClassRoom/Certificates/mobile_certificate.dart';

// ignore: must_be_immutable
class ResponsiveCertificate extends StatelessWidget {
  String userNumber;
  ResponsiveCertificate({this.userNumber});
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: DesktopCertificate(),
      tablet: TabletCertificate(),
      mobile: MobileCertificate(),
    );
  }
}
