import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_app_newocean/common/comments.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/main_title_widget.dart';
import 'package:flutter_app_newocean/common/constants.dart';
import 'package:flutter_app_newocean/common/text.dart';

class HowItWorks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.grey[100],
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MainTitleWidgetHome(
                    title: 'How It Works',
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              TextWidget(
                title: "We provide training in both Online and Offline modes",
              ),
              SizedBox(
                height: 40.0,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 15,
                children: [
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'images/local_lesson.gif',
                        width: 500.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Offline Classroom Training',
                          style: otherSmallHeaddingTextStyle,
                        ),
                      ),
                      Container(
                        //padding: EdgeInsets.all(10.0),
                        width: 500.0,
                        child: Text(
                          offlinetrainingcontent,
                          textAlign: TextAlign.justify,
                          style: otherSmallContentTextStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'images/online_lesson.gif',
                        width: 500.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Online Live Training',
                            style: otherSmallHeaddingTextStyle),
                      ),
                      Container(
                        //padding: EdgeInsets.all(10.0),
                        width: 500.0,
                        child: Text(
                          onlinetrainingcontent,
                          textAlign: TextAlign.justify,
                          style: otherSmallContentTextStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: [
                      Image.asset(
                        'images/online_lesson.gif',
                        width: 500.0,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text('Online Video Courses',
                            style: otherSmallHeaddingTextStyle),
                      ),
                      Container(
                        //padding: EdgeInsets.all(10.0),
                        width: 500.0,
                        child: Text(
                          onlinetrainingcontent,
                          textAlign: TextAlign.justify,
                          style: otherSmallContentTextStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
