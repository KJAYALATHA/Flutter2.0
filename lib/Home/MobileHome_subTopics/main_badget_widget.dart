import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/MobileHome_subTopics/badge_widget.dart';
import 'package:flutter_app_newocean/Home/MobileHome_subTopics/main_title_widget.dart';
import 'package:flutter_app_newocean/common/comments.dart';
import 'package:flutter_app_newocean/common/text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainBadgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MainTitleWidget(
        title: "Our journey through the years",
      ),
      SizedBox(
        height: 10.0,
      ),
      TextWidget(
        title: ourjourneycontent,
        style: TextStyle(),
      ),
      Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: BadgeWidget(
                icon: FontAwesomeIcons.award,
                heading: "5500+ Students trained",
                title: ourjourneycontent1,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: BadgeWidget(
                icon: FontAwesomeIcons.award,
                heading: "50+ Free seminars",
                title: ourjourneycontent2,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40.0),
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: BadgeWidget(
                icon: FontAwesomeIcons.award,
                heading: "6 International workshops",
                title: ourjournerycontent3,
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
