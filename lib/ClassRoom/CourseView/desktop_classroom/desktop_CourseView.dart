import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_newocean/ClassRoom/CourseView/all_Course/All_Course.dart';
import 'package:flutter_app_newocean/ClassRoom/CourseView/desktop_classroom/desktop_syllabus.dart';
import 'package:flutter_app_newocean/ClassRoom/CourseView/my_Course/My_course.dart';
import 'package:flutter_app_newocean/Course/Course_widget/online_course_card.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

Map<String, String> courses_icon = {};
final _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class HorizontalMenu extends StatefulWidget {
  List<String> courseList = [];
  // static Widget customWidget;
  Map menu = {};
  List<String> batchId = [];
  List<String> courseIcon = [];
  String userName;
  HorizontalMenu(
      {this.courseList,
      this.menu,
      this.batchId,
      this.courseIcon,
      this.userName});
  @override
  _HorizontalMenuState createState() => _HorizontalMenuState();
}

class _HorizontalMenuState extends State<HorizontalMenu> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('${widget.courseList} widget.courseList ');
    //HorizontalMenu.customWidget = EnrollNew();
    getSession();
  }

  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginResponsive.registerNumber = (prefs.getString('user') ?? null);
    userCourses();
    print("${CoursesView.batchId}CoursesView.batchId");
  }

  userCourses() async {
    var course = await _firestore
        .collection("new users")

        ///todo LogIn.registerNumber
        .doc(LoginResponsive.registerNumber)
        .get();
    CoursesView.courseEnroll = course["First Name"];
    CoursesView.studentemail = course["E Mail"];
    print('${CoursesView.courseEnroll} CoursesView.courseEnroll');
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.courseList.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(10.0),
            child: MouseRegion(
              child: ListTile(
                hoverColor: Colors.white,
                leading: ClipRRect(
                  child: Container(
                      height: 40,
                      width: 40,
                      child: Icon(
                        FontAwesomeIcons.graduationCap,
                        color: Colors.white,
                      )),
                  borderRadius: BorderRadius.circular(500),
                ),
                title: MouseRegion(
                  child: courseEnroll(
                    text: widget.courseList[index],
                    color: widget.menu[index],
                  ),
                ),
                onTap: () {
                  print('check ${widget.userName}');
                  print("welcome batchid ${widget.batchId[index]}");
                  setState(() {
                    widget.menu
                        .updateAll((key, value) => widget.menu[key] = false);
                    widget.menu[index] = true;
                  });

                  locator<NavigationService>().navigateTo(
                      '/ViewSchedule?courseName=${widget.courseList[index]}&batchID=${widget.batchId[index]}&userName=${CoursesView.courseEnroll}');
                },
              ),
            ),
          );
        });
  }
}

Widget courseEnroll({text, color}) {
  return Text(
    text,
    style: TextStyle(
      color: color == true ? Colors.blue : Colors.white,
      fontSize: 20.0,
    ),
  );
}

// ignore: must_be_immutable
class CoursesView extends StatefulWidget {
  static String courseEnroll;
  static String studentname;
  static String studentemail;
  static List batchId = [];

  String course;
  String trainer;
  String sess;
  String desc;
  bool isEnroll = false;
  String userID;
  bool visible;

  CoursesView(
      {this.course,
      this.sess,
      this.trainer,
      this.desc,
      this.userID,
      this.visible});
  @override
  _CoursesViewState createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  void batch_id() async {
    print("---------------------------");

    // print("${LogIn.registerNumber}register number");
    await for (var snapshot in _firestore
        .collection('new users')

        ///todo LogIn.registerNumber
        .where("Phone Number", isEqualTo: LoginResponsive.registerNumber)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        CoursesView.batchId = message['batchid'];

        print(
            '${valueController.myBatchid} testingggggggggggggggggggggggggggggggggggg');
      }
    }

    print("---------------------------");
  }

  bool visibility = true;

  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginResponsive.registerNumber = (prefs.getString('user') ?? null);
    userCourses();
    batch_id();
    print("${CoursesView.batchId}CoursesView.batchId");
  }

  @override
  void initState() {
    getSession();

    // TODO: implement initState
    super.initState();
  }

  String batchid;
  String test;

  userCourses() async {
    var course = await _firestore
        .collection("new users")

        ///todo LogIn.registerNumber
        .doc(LoginResponsive.registerNumber)
        .get();
    CoursesView.courseEnroll = course["First Name"];
    CoursesView.studentemail = course["E Mail"];
    print('${CoursesView.courseEnroll} CoursesView.courseEnroll');
  }

  final valueController = Get.find<ValueListener>();
  @override
  Widget build(BuildContext context) {
    Map menu = {};
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              MediaQuery.of(context).size.width < 1241
                  ? SizedBox()
                  : Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        //width: 250.0,
                        color: Color(0xff006793),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    "Courses",
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: _firestore
                                        .collection('new users')
                                        .snapshots(),
                                    // ignore: missing_return
                                    builder: (context1, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Text("Loading...");
                                      } else {
                                        final messages = snapshot.data.docs;

                                        //userCourses();
                                        int pos = 0;
                                        List<String> courseList = [];
                                        List<String> courseIconList = [];
                                        List<String> batchId = [];

                                        for (var message in messages) {
                                          ///todo LogIn.registerNumber
                                          if (message.id ==
                                              LoginResponsive.registerNumber) {
                                            final messageSender =
                                                message['Courses'];

                                            final batch = message['batchid'];

                                            for (var i in messageSender) {
                                              menu[pos++] = false;
                                              courseList.add(i);
                                              courseIconList
                                                  .add(courses_icon[i]);
                                            }
                                            for (var i in batch) {
                                              batchId.add(i);
                                            }
                                          }
                                        }

                                        return HorizontalMenu(
                                          courseList: courseList,
                                          menu: menu,
                                          batchId: batchId,
                                          courseIcon: courseIconList,
                                          userName: CoursesView.courseEnroll,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

              ///todo ternary operator
              Expanded(
                  flex: 6,
                  child: Obx(() {
                    if (valueController.courseType.value == "My Course") {
                      return MyCourse();
                    } else {
                      return AllCourse();
                    }
                  })

                  //Container(child: MyCourse()),
                  )
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ContentWidget extends StatefulWidget {
  static bool isVisible = false;
  static bool isShow = false;
  String course;
  String batchid;
  String trainername;
  String description;
  String duration;
  String startDate;
  String userName;

  ContentWidget(
      {this.course,
      this.batchid,
      this.trainername,
      this.userName,
      this.duration,
      this.description,
      this.startDate});

  @override
  _ContentWidgetState createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget> {
  // String description;
  // String trainername;

  userCourses() async {
    var course = await _firestore
        .collection("new users")

        ///todo LogIn.registerNumber
        .doc(LoginResponsive.registerNumber)
        .get();
    CoursesView.courseEnroll = course["First Name"];
    print('${CoursesView.courseEnroll} CoursesView.courseEnroll');
  }

  userCoursesName() async {
    var course =
        await _firestore.collection("course").doc(widget.batchid).get();
    widget.description = course["coursedescription"];
    widget.trainername = course["trainername"];
  }

  var time;
  var date;
  List timeCalculation = [];
  String resolve;
  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginResponsive.registerNumber = (prefs.getString('user') ?? null);
    print("${CoursesView.batchId}CoursesView.batchId");
    userCourses();
  }

  launchURL(String urlLink) async {
    final url = '${urlLink}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCoursesName();
    getSession();
    print("______________________________________");
  }

  @override
  Widget build(BuildContext context) {
    print("OA  batchid ${widget.batchid}");
    getSession();
    print("${CoursesView.courseEnroll}CoursesView.batchId inside build");
    return Scrollbar(
      child: Container(
        padding: EdgeInsets.only(top: 0, left: 40, right: 40),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Hi ${widget.userName},you are enroll in ${widget.course} course",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    // textBaseline: TextBaseline.ideographic,
                    children: [
                      Row(
                        children: [
                          MaterialButton(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.menu_book,
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "View Syllabus",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 17.0),
                            color: Colors.lightBlue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            hoverElevation: 5,
                            elevation: 0,
                            onPressed: () {
                              setState(() {
                                print('course ${widget.course}');
                                print('course ${widget.description}');
                                print('course ${widget.trainername}');
                                OnlineCourseCard.visiblity = false;
                              });
                              locator<NavigationService>().navigateTo(
                                  'CourseDetails?online=${widget.course}&batchID=${widget.batchid}&trainer=${widget.trainername}&description=${widget.description}');
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('course')
                    .doc(widget.batchid)
                    .collection('schedule')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text('Looding...');
                  } else {
                    List<SyllabusList> syllabusLists = [];
                    Map<int, String> scheduleDocId = {};
                    Map<int, Widget> syllabusMap = {};
                    List<int> timingList = [];
                    String courseIDCount = 'Not Scheduled';
                    timingList.sort();
                    for (var i in snapshot.data.docs) {
                      String title = i.id;
                      String subTitle = i['description'];
                      String zoomLink = i['zoom_link'];
                      String zoomPassword = i['zoom_password'];
                      Timestamp timeStamp = i['date'];
                      int duration = i['duration'];
                      String videoLink = i['video_link'];

                      int yearFormat;
                      int monthFormat;
                      int dayFormat;
                      int hourFormat;
                      int minuteFormat;
                      int secondsFormat;
                      String monthFormatString;

                      var year = DateFormat('y');
                      var month = DateFormat('MM');
                      var day = DateFormat('d');
                      var hour = DateFormat('hh');
                      var minute = DateFormat('mm');
                      var seconds = DateFormat('s');
                      var monthString = DateFormat('MMMM');

                      yearFormat = int.parse(year.format(timeStamp.toDate()));
                      monthFormat = int.parse(month.format(timeStamp.toDate()));
                      monthFormatString =
                          monthString.format(timeStamp.toDate());
                      dayFormat = int.parse(day.format(timeStamp.toDate()));
                      hourFormat = int.parse(hour.format(timeStamp.toDate()));
                      minuteFormat =
                          int.parse(minute.format(timeStamp.toDate()));
                      secondsFormat =
                          int.parse(seconds.format(timeStamp.toDate()));
                      var timeFormat =
                          DateFormat('a').format(timeStamp.toDate());
                      var defrenceTime = DateTime(
                              yearFormat,
                              monthFormat,
                              dayFormat,
                              timeFormat == 'AM' ? hourFormat : hourFormat + 12,
                              minuteFormat,
                              secondsFormat)
                          .difference(DateTime.now())
                          .inSeconds;
                      if (defrenceTime > -duration * 60 && defrenceTime < 600) {
                        courseIDCount = 'Join Now';
                      } else if (defrenceTime <= -duration * 60) {
                        courseIDCount = 'Completed';
                      } else {
                        courseIDCount = 'Not Scheduled';
                      }
                      SyllabusList syllabusAdd = SyllabusList(
                        title: title,
                        subTitle: subTitle,
                        dayFormat: dayFormat,
                        monthFormatString: monthFormatString,
                        minuteFormat: minuteFormat,
                        duration: duration.toString(),
                        hourFormat: hourFormat,
                        mainColor: courseIDCount == 'Completed'
                            ? Colors.green
                            : courseIDCount == 'Join Now'
                                ? Color(0xff0B74EF)
                                : Colors.grey[500],
                        secondaryColor: courseIDCount == 'Completed'
                            ? Colors.green[700]
                            : courseIDCount == 'Join Now'
                                ? Color(0xff04a6d9)
                                : Colors.grey[700],
                        status: courseIDCount == 'Completed'
                            ? 'Completed'
                            : courseIDCount == 'Join Now'
                                ? 'Join Live'
                                : 'Not Scheduled',
                        timing: timeFormat,
                        onPressed: courseIDCount == 'Join Now'
                            ? () {
                                locator<NavigationService>().navigateTo(
                                    '/zoomlink?zoomLink=https://brindakarthik.github.io/zoom/?meetingNumber=$zoomLink&username=${CoursesView.courseEnroll}&password=$zoomPassword');
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => ZoomIntegration(
                                //           zoomLink:
                                //           "https://brindakarthik.github.io/zoom/?meetingNumber=$zoomLink&username=abc&password=$zoomPassword",
                                //         )));
                                print(zoomPassword);
                                print(zoomLink);
                              }
                            : courseIDCount == 'Completed'
                                ? () {
                                    print('completed');
                                    launchURL(videoLink);
                                  }
                                : null,
                      );
                      // syllabusLists.add(syllabusAdd);
                      timingList.add(defrenceTime);
                      syllabusMap.addAll({defrenceTime: syllabusAdd});
                      scheduleDocId.addAll({defrenceTime: i.id});
                      print(timingList);
                    }
                    timingList.sort();
                    print(timingList);
                    for (var widget in timingList) {
                      syllabusLists.add(syllabusMap[widget]);
                      // _firestore
                      //     .collection('course')
                      //     .doc('OCNJA18')
                      //     .collection('schedule')
                      //     .doc(scheduleDocId[widget])
                      //     .update({'flag': true});
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: syllabusLists,
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CourseContent extends StatefulWidget {
  final String coursename;
  final String meetingPassword;
  final String name;
  final String finish;
  final String coursedescription;
  final String batchid;
  final String topicCover;
  final String title;
  final String time;
  final String date;
  final String schedule;
  final String meeting;
  final Function onpress;
  final String result;
  CourseContent(
      {this.coursename,
      this.batchid,
      this.meeting,
      this.name,
      this.finish,
      this.coursedescription,
      this.title,
      this.time,
      this.date,
      this.schedule,
      this.topicCover,
      this.onpress,
      this.result,
      this.meetingPassword});

  @override
  _CourseContentState createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  @override
  Widget build(BuildContext context) {
    String zoomLink =
        "https://brindakarthik.github.io/zoom/?meetingNumber=${widget.meeting}&username=abc&password=${widget.meetingPassword}";
    print("${widget.name}CoursesView.courseEnroll");
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  //margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(15.0),
                  //height: 300.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black54),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.title}",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text("${widget.coursedescription}"),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        "Scheduled At",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined),
                              Text("${widget.date}"),
                              SizedBox(
                                width: 20.0,
                              ),
                              Icon(Icons.access_time),
                              Text("${widget.time}"),
                            ],
                          ),
                          Row(
                            children: [
                              MaterialButton(
                                padding: EdgeInsets.all(20.0),
                                color: widget.result == "true"
                                    ? Colors.blue
                                    : Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(05.0))),
                                onPressed: widget.onpress,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.videocam,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      "Join here",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  Map menu = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      //width: 250.0,
      color: Color(0xff006793),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            //color: Color(0xff006793).withOpacity(0.5),
            child: Column(
              children: [
                Text(
                  "Courses",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: _firestore.collection('new users').snapshots(),
                  // ignore: missing_return
                  builder: (context1, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading...");
                    } else {
                      final messages = snapshot.data.docs;

                      //userCourses();
                      int pos = 0;
                      List<String> courseList = [];
                      List<String> courseIconList = [];
                      List<String> batchId = [];

                      for (var message in messages) {
                        ///todo LogIn.registerNumber
                        if (message.id == LoginResponsive.registerNumber) {
                          final messageSender = message['Courses'];
                          final batch = message['batchid'];
                          for (var i in messageSender) {
                            menu[pos++] = false;
                            courseList.add(i);
                            courseIconList.add(courses_icon[i]);
                          }
                          for (var i in batch) {
                            batchId.add(i);
                          }
                        }
                      }

                      return HorizontalMenu(
                        courseList: courseList,
                        menu: menu,
                        batchId: batchId,
                        courseIcon: courseIconList,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
