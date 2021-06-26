import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/main_title_widget.dart';
import 'package:flutter_app_newocean/common/comments.dart';
import 'package:flutter_app_newocean/common/constants.dart';
import 'package:flutter_app_newocean/common/text.dart';

class WhatIsNew extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
          child: Column(
            children: [
              MainTitleWidgetHome(
                title: 'What’s New at Ocean Academy',
              ),
              SizedBox(
                height: 30.0,
              ),
              TextWidget(
                title: whatIsNew,
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
                  child: Text(
                    'Ocean Academy Launches Its Own Private Social Network for Learners',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: textColor),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Coming soon: our human to human matching engine will be able to introduce you to potential friends, partners and even dates with surprising accuracy.",
                    style: otherSmallContentTextStyle,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Image.asset(
              'images/what\'s new.png',
            ),
          ],
        ),
      ],
    );
  }
}
