import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Menu/Menu_DeskTop.dart';
import 'package:flutter_app_newocean/common/constants.dart';
import 'package:flutter_app_newocean/route/Provider/provider_routing.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'package:flutter_app_newocean/vedio_player/vedio_player.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app_newocean/Extension/Hover_Extension.dart';

final _firestore = FirebaseFirestore.instance;
String hometitle;
String homecontent;

class SliderWidget extends StatefulWidget {
  @override
  _SliderWidgetState createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  void getData() async {
    final message =
        await _firestore.collection('home').doc("lkAl4KhYwAkOjUpjo3SF").get();

    //print(courses.data()['img']);
    hometitle = message.data()['homeheading'];
    homecontent = message.data()['homepagecontent'];
    Provider.of<SliderContent>(context, listen: false)
        .updateValue(hometitle, homecontent);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 40.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/Slide.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Container(child:
                Consumer<SliderContent>(builder: (context1, cart, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Provider.of<SliderContent>(context, listen: false).title}',
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: kfontname,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    "${Provider.of<SliderContent>(context, listen: false).description}",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontFamily: kfontname,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      menu.updateAll((key, value) => menu[key] = false);
                      menu['Courses'] = true;
                      locator<NavigationService>().navigateTo(CourseRoute);
                    },
                    color: Colors.white,
                    textColor: textColor,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Enroll now ",
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: kfontname,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    ),
                  ).moveUpOnHover,
                ],
              );
            })),
          ),
          Expanded(
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.87)
                ..rotateY(0.0005),
              alignment: FractionalOffset.center,
              child: Container(
                margin: EdgeInsets.only(right: 50.0),
                child: VideoPlayerScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
