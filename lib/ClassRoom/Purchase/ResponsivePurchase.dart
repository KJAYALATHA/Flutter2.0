import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/ClassRoom/Purchase/desktop_purchase_details.dart';
import 'package:flutter_app_newocean/ClassRoom/Purchase/mobile_purchase_details.dart';
import 'package:flutter_app_newocean/ClassRoom/Purchase/tablet_purchase_details.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ResponsivePurchase extends StatefulWidget {
  String userNumber;
  ResponsivePurchase({this.userNumber});
  @override
  _ResponsivePurchaseState createState() => _ResponsivePurchaseState();
}

class _ResponsivePurchaseState extends State<ResponsivePurchase> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobilePurchaseDetails(),
      tablet: TabletPurchaseDetails(),
      desktop: DesktopPurchaseDetails(),
    );
  }
}
