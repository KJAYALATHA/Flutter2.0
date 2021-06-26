import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Buttons/switch_button.dart';
import 'package:flutter_app_newocean/Course/Course_widget/offline_course_card.dart';
import 'package:flutter_app_newocean/Course/Course_widget/online_course_card.dart';
import 'package:flutter_app_newocean/Footer/mobile_footer.dart';
import 'package:flutter_app_newocean/Footer/tablet_footer.dart';
import 'package:flutter_app_newocean/Footer/widgets/layout_builder.dart';
import 'package:flutter_app_newocean/Menu/Menu_DeskTop.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

final _firestore = FirebaseFirestore.instance;

class DesktopCourse extends StatefulWidget {
  @override
  _DesktopCourseState createState() => _DesktopCourseState();
}

class _DesktopCourseState extends State<DesktopCourse> {
  bool isOnline = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menu.updateAll((key, value) => menu[key] = false);
    menu['Courses'] = true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/oa_bg.png'),
                repeat: ImageRepeat.repeatY)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SwitchButton(
                  closeChild: Container(
                    width: 275,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Online',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  openChild: Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Offline',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  sliderChild: isOnline
                      ? Icon(
                          Icons.arrow_left,
                          color: Colors.blue[800],
                          size: 45,
                        )
                      : Icon(
                          Icons.arrow_right,
                          color: Colors.blue,
                          size: 45,
                        ),
                  open: isOnline,
                  onChanged: (value) {
                    setState(() {
                      isOnline = value;
                    });
                  },
                ),
              ],
            ),
            !isOnline
                ? StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('course').snapshots(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Loading...");
                      } else {
                        final messages = snapshot.data.docs;

                        List<OnlineCourseCard> messageBubbles = [];
                        for (var message in messages) {
                          final messageText = message['trainername'];
                          final messageSender = message['coursename'];
                          final messageDuration = message['duration'];
                          final messageImage = message['img'];
                          final messageDescription =
                              message['coursedescription'];
                          final messageBatchid = message['batchid'];
                          final timeStamp = message['date1'];

                          String monthFormat;
                          String dayTime;
                          int dayFormat;
                          int hourFormat;
                          int minuteFormat;

                          var month = DateFormat('MMMM');
                          var day = DateFormat('d');
                          var hour = DateFormat('hh');
                          var minute = DateFormat('mm');
                          var daytime = DateFormat('a');

                          monthFormat = month.format(timeStamp.toDate());
                          dayFormat = int.parse(day.format(timeStamp.toDate()));
                          hourFormat =
                              int.parse(hour.format(timeStamp.toDate()));
                          minuteFormat =
                              int.parse(minute.format(timeStamp.toDate()));
                          dayTime = daytime.format(timeStamp.toDate());

                          final messageBubble = OnlineCourseCard(
                            trainername: messageText,
                            coursename: messageSender,
                            duration: messageDuration,
                            time: '$hourFormat:$minuteFormat $dayTime',
                            date: '$dayFormat $monthFormat',
                            image: messageImage,
                            description: messageDescription,
                            batchid: messageBatchid,
                            onPressed: () {
                              setState(() {
                                OnlineCourseCard.visiblity = true;
                              });
                              print(messageSender);
                              locator<NavigationService>().navigateTo(
                                  'CourseDetails?online=$messageSender&batchID=$messageBatchid&trainer=$messageText&description=$messageDescription');
                            },
                          );
                          // Text('$messageText from $messageSender');
                          messageBubbles.add(messageBubble);
                        }

                        return Wrap(
                          alignment: WrapAlignment.center,
                          children: messageBubbles,
                        );
                      }
                    },
                  )
                : StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('offline_course').snapshots(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Loading...");
                      } else {
                        final messages = snapshot.data.docs;

                        List<OfflineCourseCard> offlineCourse = [];
                        for (var message in messages) {
                          final messageSender = message['coursename'];
                          final messagePdflink = message['pdflink'];
                          final messageImage = message['img'];

                          final messageCourse = OfflineCourseCard(
                            coursename: messageSender,
                            pdfLink: messagePdflink,
                            image: messageImage,
                          );
                          // Text('$messageText from $messageSender');
                          offlineCourse.add(messageCourse);
                        }

                        return Wrap(
                          alignment: WrapAlignment.center,
                          children: offlineCourse,
                        );
                      }
                    },
                  ),
            ScreenTypeLayout(
              desktop: DesktopFooterLayout(),
              tablet: TabletFooter(),
              mobile: Footer(),
            ),
          ],
        ),
      ),
    );
  }
}
