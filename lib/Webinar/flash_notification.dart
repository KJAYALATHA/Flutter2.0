import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Webinar/WebinarCard_Desktop/webinar_list.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import '../common/constants.dart';
import '../route/navigation_locator.dart';
import '../route/navigation_service.dart';
import '../route/routeNames.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';

final _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class FlashNotification extends StatefulWidget {
  FlashNotification(
      {this.joinButton,
      this.dismissNotification,
      this.joinButtonName,
      this.webinar,
      this.upcomingButton});
  Function upcomingButton;
  Function joinButton;
  Function dismissNotification;
  String joinButtonName = 'JOIN';
  Map webinar;

  @override
  _FlashNotificationState createState() => _FlashNotificationState();
}

class _FlashNotificationState extends State<FlashNotification> {
  bool isUpcomingWebinar = true;
  final valueController = Get.find<ValueListener>();
  String comingSoon = 'Webinar';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // int x = (prefs.getInt('login') ?? 0);
    LoginResponsive.registerNumber = (prefs.getString('user') ?? null);
  }

  @override
  Widget build(BuildContext context) {
    print('@@@@@@@@@@@@@@@@@@@@@@@@');
    print(widget.webinar);
    // if (comingSoon == 'Webinar Coming soon') {
    //   valueController.isFlashNotification.value = false;
    // }
    return Container(
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(),
          Row(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('Webinar').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  } else {
                    final messages = snapshot.data.docs;

                    List<FlashDb> courseList = [];
                    List<int> timingList = [];
                    Map<int, Widget> courseMap = {};
                    List<Widget> currentWebinar = [];
                    Map<String, Map> timingMap = {};
                    for (var message in messages) {
                      Timestamp time = message['timestamp'];
                      final freeWebinarContent = message['course'];
                      final courseName = message['course'];
                      final payment = message['payment'];
                      int duration = int.parse(message['webinar duration']);

                      int yearFormat;
                      int monthFormat;
                      int dayFormat;
                      int hourFormat;
                      int minuteFormat;
                      int secondsFormat;

                      var year = DateFormat('y');
                      var month = DateFormat('MM');
                      var day = DateFormat('d');
                      var hour = DateFormat('hh');
                      var minute = DateFormat('mm');
                      var seconds = DateFormat('s');

                      yearFormat = int.parse(year.format(time.toDate()));
                      monthFormat = int.parse(month.format(time.toDate()));
                      dayFormat = int.parse(day.format(time.toDate()));
                      hourFormat = int.parse(hour.format(time.toDate()));
                      minuteFormat = int.parse(minute.format(time.toDate()));
                      secondsFormat = int.parse(seconds.format(time.toDate()));
                      var timeFormat = DateFormat('a').format(time.toDate());

                      var defrenceTime = DateTime(
                              yearFormat,
                              monthFormat,
                              dayFormat,
                              timeFormat == 'AM' ? hourFormat : hourFormat + 12,
                              minuteFormat,
                              secondsFormat)
                          .difference(DateTime.now())
                          .inSeconds;

                      //for mail info
                      String toTimeFormat = timeFormat;
                      int toTime = hourFormat;
                      int toDuration = duration;
                      if (toDuration >= 60) {
                        var hourcalculate = toDuration ~/ 60;
                        toDuration -= hourcalculate * 60;
                        toTime += hourcalculate;
                        if (toTime == 12) {
                          if (timeFormat == 'AM') {
                            toTimeFormat = 'PM';
                          } else {
                            toTimeFormat = 'AM';
                          }
                        } else if (toTime > 12) {
                          toTime -= 12;
                          if (timeFormat == 'AM') {
                            toTimeFormat = 'PM';
                          } else {
                            toTimeFormat = 'AM';
                          }
                        }
                      }

                      var monthString = DateFormat('MMMM');
                      var monthFormatString = monthString.format(time.toDate());
                      Map dateForMail = {
                        'Year': yearFormat,
                        'Month': monthFormatString,
                        'Day': dayFormat,
                        'Hours': hourFormat,
                        'To Hours': toTime,
                        'Minutes': minuteFormat,
                        'To Minutes': toDuration,
                        'DayFormat': timeFormat,
                        'To DayFormat': toTimeFormat
                      };
                      timingMap.addAll({courseName: dateForMail});

                      if (defrenceTime > 0) {
                        final webinar = FlashDb(
                          content: freeWebinarContent,
                          joinButton: widget.joinButton,
                          dismissNotification: widget.dismissNotification,
                          payment: payment,
                          wbinarLive: currentWebinar,
                          mailTiming: dateForMail,
                        );
                        timingList.add(defrenceTime);
                        timingList.sort();

                        courseMap.addAll({defrenceTime: webinar});
                      } else if (defrenceTime > -duration) {
                        final webinar = FlashDb(
                          content: freeWebinarContent,
                          mailTiming: dateForMail,
                          joinButton: widget.joinButton,
                          dismissNotification: widget.dismissNotification,
                          payment: payment,
                          wbinarLive: currentWebinar,
                        );
                        currentWebinar.add(webinar);
                      }
                    }
                    for (var i in timingList) {
                      courseList.add(courseMap[i]);
                    }
                    WebinarCard.timing = timingMap;
                    if (currentWebinar.isEmpty && courseList.isEmpty) {
                      // valueController.isFlashNotification.value = false;

                      comingSoon = 'Webinar Coming soon';

                      print('$currentWebinar $courseList');

                      isUpcomingWebinar = false;
                    }

                    return Container(
                      child: Column(
                        children: [
                          currentWebinar.isEmpty && courseList.isEmpty
                              ? SizedBox()
                              : currentWebinar.isEmpty
                                  ? courseList[0]
                                  : currentWebinar[0]
                        ],
                      ),
                    );
                  }
                },
              ),
              isUpcomingWebinar
                  ? Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: FlatButton(
                        child: Text(
                          "Upcoming",
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontFamily: kfontname),
                        ),
                        height: 40,
                        color: Colors.white,
                        onPressed: () {
                          locator<NavigationService>()
                              .navigateTo(UpcomingWebinarRoute);
                        },
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        '$comingSoon',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
            ],
          ),
          IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: widget.dismissNotification),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class FlashDb extends StatefulWidget {
  Function joinButton;
  Function upcomingButton;
  Function dismissNotification;
  Map mailTiming;
  String joinButtonName = 'JOIN';
  List<Widget> wbinarLive;
  String content;
  String payment;
  FlashDb(
      {this.content,
      this.mailTiming,
      this.joinButton,
      this.dismissNotification,
      this.joinButtonName,
      this.payment,
      this.upcomingButton,
      this.wbinarLive});

  @override
  _FlashDbState createState() => _FlashDbState();
}

class _FlashDbState extends State<FlashDb> {
  var remaingTime = 0;
  final valueController = Get.find<ValueListener>();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection('Webinar').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading...");
            } else {
              var timeStamp;
              final time = snapshot.data.docs;
              for (var i in time) {
                print('uuuuuuuuuuuuuuuuuuuuuuuyyyyyyyyyyyyyyyyyyg');
                print(i['course']);

                if (widget.content == i['course']) {
                  timeStamp = i['timestamp'];
                }
              }
              int yearFormat;
              int monthFormat;
              int dayFormat;
              int hourFormat;
              int minuteFormat;
              int secondsFormat;

              var year = DateFormat('y');
              var month = DateFormat('MM');
              var day = DateFormat('d');
              var hour = DateFormat('hh');
              var minute = DateFormat('mm');
              var seconds = DateFormat('s');

              yearFormat = int.parse(year.format(timeStamp.toDate()));
              monthFormat = int.parse(month.format(timeStamp.toDate()));
              dayFormat = int.parse(day.format(timeStamp.toDate()));
              hourFormat = int.parse(hour.format(timeStamp.toDate()));
              minuteFormat = int.parse(minute.format(timeStamp.toDate()));
              secondsFormat = int.parse(seconds.format(timeStamp.toDate()));
              var timeFormat = DateFormat('a').format(timeStamp.toDate());

              var defrenceTime = DateTime(
                      yearFormat,
                      monthFormat,
                      dayFormat,
                      timeFormat == 'AM' ? hourFormat : hourFormat + 12,
                      minuteFormat,
                      secondsFormat)
                  .difference(DateTime.now())
                  .inSeconds;
              print('$defrenceTime testing timing');
              remaingTime = defrenceTime > 0 ? defrenceTime : 0;
              if (remaingTime != 0) {
                return SlideCountdownClock(
                  duration: Duration(seconds: remaingTime),
                  separator: ' : ',
                  textStyle: TextStyle(
                      fontSize: 25, fontFamily: kfontname, color: Colors.white),
                  separatorTextStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Ubuntu'),
                  shouldShowDays: true,
                  onDone: () {
                    setState(() {
                      remaingTime = 0;
                    });
                  },
                );
              } else {
                return Container(
                  // color: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'live Streaming Started',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                );
              }
            }
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          height: 20,
          width: 2,
          color: Colors.white,
        ),
        RichText(
            text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 20),
                children: [
              TextSpan(text: widget.content),
              TextSpan(
                  text: ' Value based webinar ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'Now'),
            ])),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: FlatButton(
            child: Text(
              'Join',
              style: TextStyle(
                  color: remaingTime != 0 ? Colors.blue : Colors.red,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: kfontname),
            ),
            height: 40,
            color: Colors.white,
            onPressed: () {
              valueController.isFlashNotification.value = false;
              valueController.navebars.value = 'Webinar';

              locator<NavigationService>()
                  .navigateTo('MobileWebinarJoin?id=${widget.content}');
            },
          ),
        ),
      ],
    );
  }
}
