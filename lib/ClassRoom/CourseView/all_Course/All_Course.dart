import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_newocean/ClassRoom/CourseView/my_Course/My_course.dart';
import 'package:flutter_app_newocean/Course/Course_widget/online_course_card.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firestore = FirebaseFirestore.instance;

class AllCourse extends StatefulWidget {
  bool isEnroll = false;
  static List availableBatch = [];

  @override
  _AllCourseState createState() => _AllCourseState();
}

class _AllCourseState extends State<AllCourse> {
  List<String> subjects = [];

  String courseId;

  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginResponsive.registerNumber = (prefs.getString('user') ?? null);
  }

  @override
  void initState() {
    // TODO: implement initState

    getSession();
    super.initState();
  }

  List EnrollList = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/oa_bg.png'),
              repeat: ImageRepeat.repeatY)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection("new users").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  } else {
                    final messages = snapshot.data.docs;

                    for (var message in messages) {
                      /// print("${LogIn.registerNumber}LogIn.registerNumber");
                      if (message.id == LoginResponsive.registerNumber) {
                        EnrollList = message['Courses'];
                        print("${EnrollList}EnrollList");
                      }
                    }
                  }
                  return StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('course').snapshots(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Loading...");
                      } else {
                        final messages = snapshot.data.docs;

                        List<AllCourseDb> courseList = [];

                        for (var message in messages) {
                          if (!EnrollList.any((element) =>
                              element.contains(message["coursename"]))) {
                            final messageText = message['trainername'];
                            final messageSender = message['coursename'];
                            final messageSession = message['session'];
                            final messageTime = message['time'];
                            final messageImage = message['img'];
                            final messageDescription =
                                message['coursedescription'];
                            final messageBatchId = message['batchid'];

                            final CourseDbVariable = AllCourseDb(
                              trainername: messageText,
                              coursename: messageSender,
                              session: messageSession,
                              time: messageTime,
                              image: messageImage,
                              description: messageDescription,
                              batchid: messageBatchId,
                            );
                            courseList.add(CourseDbVariable);
                          }
                        }
                        return Wrap(
                          alignment: WrapAlignment.center,
                          children: courseList,
                        );
                      }
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class AllCourseDb extends StatefulWidget {
  static bool visiblity = false;
  AllCourseDb(
      {this.coursename,
      this.trainername,
      this.session,
      this.time,
      this.image,
      this.description,
      this.batchid});
  final String coursename;
  final String trainername;
  final String session;
  final String time;
  final String image;
  final String description;
  final String batchid;

  @override
  _AllCourseDbState createState() => _AllCourseDbState();
}

class _AllCourseDbState extends State<AllCourseDb> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          MyCourseDb.visiblity = true;
        });
        setState(() {
          //OnlineCourse.visiblity = false;
        });
        setState(() {
          // Navbar.visiblity = false;
        });
        print("${widget.coursename}widget.coursename");
        // Provider.of<SyllabusView>(context, listen: false).updateCourseSyllabus(
        //     routing: CourseDetails(
        //       batch: widget.batchid,
        //       course: widget.coursename,
        //       trainer: widget.trainername,
        //       sess: widget.time,
        //       desc: widget.description,
        //     ));
      },
      child: Container(
        margin: EdgeInsets.all(35.0),
        //padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        height: 300.0,
        width: 300.0,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            borderRadius: BorderRadius.circular(15.0)),
        child: Column(
          children: [
            // SizedBox(
            //   height: 5,
            // ),
            MouseRegion(
              //cursor: SystemMouseCursors.click,
              child: Container(
                width: 300,
                height: 160,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image(
                    image: NetworkImage('${widget.image}'),
                    fit: BoxFit.cover,
                    // width: 350.0,
                    // height: 100.0,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "${widget.coursename} full package course | ${widget.trainername} | Ocean Academy",
                    style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.black54,
                      fontFamily: "Gilroy",
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                        hoverColor: Colors.blue[50],
                        height: 45,
                        minWidth: 250,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                          side: BorderSide(color: Colors.blue, width: 1),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          setState(() {
                            MyCourseDb.visiblity = true;
                          });
                          setState(() {
                            OnlineCourseCard.visiblity = true;
                          });
                          setState(() {
                            // Navbar.visiblity = false;
                          });
                          print("${widget.coursename}widget.coursename");
                          locator<NavigationService>().navigateTo(
                              'CourseDetails?online=${widget.coursename}&batchID=${widget.batchid}&trainer=${widget.trainername}&description=${widget.description}');
                        },
                        child: Text(
                          'BUY NOW',
                          style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.blue,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Gilroy",
                          ),
                        ))

                    /// todo . .moveUpOnHover,
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
