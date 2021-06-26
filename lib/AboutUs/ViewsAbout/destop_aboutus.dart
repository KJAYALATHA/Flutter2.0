import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/AboutUs/ContainerWidget/desktop_container.dart';
import 'package:flutter_app_newocean/Footer/desktop_footer_lg.dart';
import 'package:flutter_app_newocean/TopNavigationBar/desktop_topnavigationbar.dart';
import 'package:flutter_app_newocean/common/constants.dart';
import 'package:flutter_app_newocean/common/text.dart';
import 'tablet_aboutus.dart';

const ktopic = TextStyle(
    fontSize: 25.0, color: Colors.black, fontWeight: FontWeight.normal);
const kcontent = TextStyle(
  fontSize: 20.0,
  color: Colors.black45,
);

// ignore: must_be_immutable
class DesktopAboutUs extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  var myGroup = AutoSizeGroup();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      if (constrains.maxWidth < 1240) {
        return TabletAboutUs();
      } else {
        return ListView.builder(
          // shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) {
            return Container(
              color: Colors.white,
              child: Column(
                children: [
                  DesktopTopNavigationBar(
                    title: "About Us",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'About us Ocean Academy',
                                style: TextStyle(
                                  color: Color(0xff0091d2),
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: kfontname,
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(aboutcontent1,
                                  textAlign: TextAlign.justify,
                                  style: contentTextStyle),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(aboutcontent2,
                                  textAlign: TextAlign.justify,
                                  style: contentTextStyle),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(aboutcontent3,
                                  textAlign: TextAlign.justify,
                                  style: contentTextStyle),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(aboutcontent4,
                                  textAlign: TextAlign.justify,
                                  style: contentTextStyle),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 300.0,
                                    height: 300.0,
                                    //height: 300,
                                    margin: EdgeInsets.fromLTRB(
                                        120.0, 0.0, 0.0, 50.0),
                                    padding: EdgeInsets.fromLTRB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image(
                                        image: AssetImage('images/lap.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  Container(
                                    width: 300.0,
                                    height: 300.0,
                                    margin: EdgeInsets.fromLTRB(
                                        20.0, 100.0, 0.0, 20.0),
                                    padding: EdgeInsets.fromLTRB(
                                        0.0, 0.0, 20.0, 0.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10.0),
                                          bottomLeft: Radius.circular(10.0)),
                                      child: Image(
                                        image: AssetImage('images/lap.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xff0091d2),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Column(
                    children: [
                      Text(
                        "Meet our Mentors",
                        style: TextStyle(
                            color: Color(0xff0091d2),
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: kfontname),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Wrap(children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('Mentor').snapshots(),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text("Loading...");
                        } else {
                          final messages = snapshot.data.docs;
                          List<ContainerWidget> trainerContent = [];
                          //List<String> subjects = [];
                          for (var message in messages) {
                            // if (message.data()['coursename'] == "python") {
                            final trainerName = message['name'];
                            final trainerDesignation = message['designation'];
                            final trainerImage = message['image'];
                            final fbLink = message['fbLink'];
                            final gmailLink = message['gmailLink'];
                            final linkedinLink = message['linkedinLink'];
                            final twitter = message['twitter'];

                            final messageContent = ContainerWidget(
                              fbLink: fbLink,
                              gmailLink: gmailLink,
                              linkedinLink: linkedinLink,
                              twitterLink: twitter,
                              designation: trainerDesignation,
                              trainerName: trainerName,
                              image: trainerImage,
                            );
                            trainerContent.add(messageContent);
                            // }
                          }
                          return Wrap(
                            alignment: WrapAlignment.center,
                            children: trainerContent,
                          );
                        }
                      },
                    ),
                  ]),
                  DesktopFooterLg()
                ],
              ),
            );
          },
        );
      }
    });
  }
}
