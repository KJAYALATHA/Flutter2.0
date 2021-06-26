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
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
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
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                width: 400.0,
                child: Column(
                  children: [
                    Text(
                      'Ocean Academy Launches Its Own Private Social Network for Learners',
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: textColor),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                        "Coming soon: our human to human matching engine will be able to introduce you to potential friends, partners and even dates with surprising accuracy.",
                        style: contentTextStyle)
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 30.0,
            ),
            Expanded(
              flex: 3,
              child: Container(
                width: 500.0,
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Image.asset(
                  'images/what\'s new.png',
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
