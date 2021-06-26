import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/MobileHome_subTopics/main_title_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            width: 320,
            height: 100,
            child: Image(
              image: NetworkImage(a),
              fit: BoxFit.contain,
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
      children: [
        Container(
          padding: EdgeInsets.only(top: 20.0, bottom: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainTitleWidget(
                title: "Upcoming Courses",
              ),
              SizedBox(height: 40.0),
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
                        List<Container> dbUpcoming = [];
                        for (var message in messages) {
                          final images = message['upcomingcourse'];
                          Container messageContent = Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: 320,
                                height: 100,
                                child: Image(
                                  image: NetworkImage(images),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );

                          dbUpcoming.add(messageContent);
                        }
                        return Row(
                          children: [
                            DB(images: dbUpcoming),
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
          viewportFraction: 0.6,
        ),
        items: images,
      ),
    );
  }
}
