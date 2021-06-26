import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/main_title_widget.dart';
import 'package:flutter_app_newocean/common/comments.dart';
import 'package:flutter_app_newocean/common/text.dart';

class UpcomingCourse extends StatefulWidget {
  @override
  _UpcomingCourseState createState() => _UpcomingCourseState();
}

class _UpcomingCourseState extends State<UpcomingCourse> {
  final _firestore = FirebaseFirestore.instance;

  List<Container> bubbles = [];

  void getData() async {
    final message = await _firestore.collection('Upcoming_Course').get();
    print(message.docs);

    for (var courses in message.docs) {
      String a = courses['upcomingcourse'];
      Widget coursIMG = Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: 400,
            child: Image(
              image: NetworkImage(a),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

      bubbles.add(coursIMG);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/oa_bg.png'))),
          padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: MainTitleWidgetHome(
                  title: "Upcoming Courses",
                ),
              ),
              SizedBox(height: 30.0),
              TextWidget(
                title: upcomingcontent,
              ),
              SizedBox(height: 70.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder<QuerySnapshot>(
                    stream:
                        _firestore.collection('Upcoming_Course').snapshots(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Loading...");
                      } else {
                        final messages = snapshot.data.docs;
                        // ignore: non_constant_identifier_names
                        List<Container> DBUpcoming = [];
                        for (var message in messages) {
                          final images = message['upcomingcourse'];
                          Container messageContent = Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Container(
                                width: 420,
                                height: 400,
                                child: Image(
                                  image: NetworkImage(images),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );

                          DBUpcoming.add(messageContent);
                        }
                        return Row(
                          children: [
                            DB(images: DBUpcoming),
                          ],
                        );
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class DB extends StatelessWidget {
  List<Widget> images = [];

  DB({this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        options: CarouselOptions(
          pageSnapping: true,
          height: 220,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: Duration(milliseconds: 200),
          viewportFraction: 0.3,
        ),
        items: images,
      ),
    );
  }
}
