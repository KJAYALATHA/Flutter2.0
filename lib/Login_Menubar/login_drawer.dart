import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/Menu/Menubar_drawer.dart';
import 'package:flutter_app_newocean/ocean_icon/ocean_icons.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _firestore = FirebaseFirestore.instance;

///drawer content

// ignore: must_be_immutable
class HorizontalMenu extends StatefulWidget {
  List<String> courseList = [];
  // static Widget customWidget;
  Map menu = {};
  List<String> batchId = [];
  List<String> courseIcon = [];
  HorizontalMenu({this.courseList, this.menu, this.batchId, this.courseIcon});
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
  }

  @override
  Widget build(BuildContext context) {
    final state = RootDrawer.of(context);
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
                  print("welcome batchid ${widget.batchId[index]}");
                  setState(() {
                    widget.menu
                        .updateAll((key, value) => widget.menu[key] = false);
                    widget.menu[index] = true;
                  });
                  locator<NavigationService>().navigateTo(
                      '/ViewSchedule?courseName=${widget.courseList[index]}&batchID=${widget.batchId[index]}');
                  state.close();
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

///end

class LoginDrawer extends StatefulWidget {
  static List courseMenuDrawer = [];
  @override
  _LoginDrawerState createState() => _LoginDrawerState();
}

class _LoginDrawerState extends State<LoginDrawer> {
  void tab_batch_id() async {
    print("----------1234-----------------");

    // print("${LogIn.registerNumber}register number");
    await for (var snapshot in _firestore
        .collection('new users')

        ///todo LogIn.registerNumber
        .where("Phone Number", isEqualTo: LoginResponsive.registerNumber)
        .snapshots(includeMetadataChanges: true)) {
      for (var message in snapshot.docs) {
        LoginDrawer.courseMenuDrawer = message['batchid'];
      }
    }

    print("---------------------------");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tab_batch_id();
  }

  @override
  Widget build(BuildContext context) {
    Map menu = {};
    final state = RootDrawer.of(context);
    Map<String, String> courses_icon = {};
    return Container(
      width: 250,
      color: Colors.blue[800],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.blue,
            child: Column(
              children: [
                Icon(
                  Ocean.oa,
                  color: Colors.white,
                  size: 50,
                ),
                Text(
                  "Ocean Academy",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 15, top: 8),
                  color: Colors.transparent,
                  height: 1,
                )
              ],
            ),
          ),
          Expanded(
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
                      ///todo seesion id to messege.id
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
          )),
        ],
      ),
    );
  }
}
