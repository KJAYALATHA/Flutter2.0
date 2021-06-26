import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/main_title_widget.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/tab_widget/badge_widget.dart';
import 'package:flutter_app_newocean/common/text.dart';

import 'package:flutter_app_newocean/common/comments.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainBadgeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        color: Color(0xFFF7F7F7),
        child: Column(children: [
          SizedBox(
            height: 30.0,
          ),
          MainTitleWidgetHome(
            title: "Our journey through the years",
          ),
          SizedBox(
            height: 30.0,
          ),
          TextWidget(
            title: ourjourneycontent,
          ),
          SizedBox(
            height: 50.0,
          ),
          Container(
            child: Column(
              // alignment: WrapAlignment.center,
              // spacing: 15,
              // runSpacing: 20,
              children: [
                Container(
                  color: Colors.grey[200],
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: BadgeWidget(
                    icon: FontAwesomeIcons.award,
                    heading: "5500+ Students trained",
                    title: ourjourneycontent2,
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: BadgeWidget(
                    icon: FontAwesomeIcons.award,
                    heading: "50+ Free seminars",
                    title: ourjournerycontent3,
                  ),
                ),
                Container(
                  color: Colors.grey[200],
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: BadgeWidget(
                    icon: FontAwesomeIcons.award,
                    heading: "6 International workshops",
                    title: ourjourneycontent4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          )
        ]),
      ),
    );
  }
}
