import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Webinar/WebinarCard_Desktop/webinar_list.dart';
import 'package:flutter_app_newocean/Webinar/mobile_wbinar/mobile_webinar_list.dart';

import 'package:responsive_builder/responsive_builder.dart';

class ResponsiveWebinarCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileWebinarCard(),
      desktop: WebinarCard(),
      tablet: MobileWebinarCard(),
    );
  }
}
