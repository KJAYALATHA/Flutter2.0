// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_newocean/AboutUs/ViewsAbout/Responsive_about.dart';
import 'package:flutter_app_newocean/common/constants.dart';
import 'package:flutter_app_newocean/common/material_button.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;

subscribeDialog(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        content: Container(
          height: 300,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Thanks for Subscribe',
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset('images/tick-gif.gif'),
            ],
          ),
        ),
      );
    },
  );
}

subscribeFailedDialog(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.transparent,
        content: Container(
          height: 300,
          width: 250,
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Check your Email',
                style: TextStyle(fontSize: 25, color: Colors.grey),
              ),
              Image.asset('images/wrong-symbol.gif'),
            ],
          ),
        ),
      );
    },
  );
}

class TabletFooter extends StatefulWidget {
  @override
  _TabletFooterState createState() => _TabletFooterState();
}

class _TabletFooterState extends State<TabletFooter> {
  TextEditingController _subscribe = TextEditingController();

  void getData() async {
    http.Response response = await http.get(Uri(
        path:
            'http://free-webinar-registration.herokuapp.com/?name=Brinda&email=${_subscribe.text}&type=subscribe'));

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        color: Color(0xFC004478),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        // Provider.of<Routing>(context, listen: false)
                        //     .updateRouting(widget: Home());
                      },
                      child: Text(
                        'OCEAN ACADEMY',
                        style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: kfontname),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: 450,
                    child: Text(
                      'Ocean was founded on the principle of building and implementing '
                      'great ideas that drive progress for the students ond clients.',
                      style: TextStyle(
                          height: 1.5,
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: kfontname),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            locator<NavigationService>()
                                .navigateTo(ContactUsRoute);
                          },
                          child: Container(
                              child: Text(
                            'CONTACT US',
                            style: kbottom,
                          )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            locator<NavigationService>()
                                .navigateTo(ServiceRoute);
                          },
                          child: Container(
                              child: Text(
                            'SERVICES',
                            style: kbottom,
                          )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            locator<NavigationService>()
                                .navigateTo(CourseRoute);
                          },
                          child: Container(
                              child: Text(
                            'COURSES',
                            style: kbottom,
                          )),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                          child: footerMouseRegion(
                              text: "ABOUT US",
                              onTap: () {
                                locator<NavigationService>()
                                    .navigateTo(AboutRoute);
                              })),
                      SizedBox(height: 20.0),
                      GestureDetector(
                          child: footerMouseRegion(text: "HELP", onTap: () {})),
                    ],
                  ),
                ),
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                      border: Border(
                          right: BorderSide(
                              width: 1, color: Colors.white.withOpacity(0.5)))),
                ),
                Container(
                  width: 250,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      GestureDetector(
                          child: footerMouseRegion(text: "FAQ", onTap: () {})),
                      SizedBox(height: 17.0),
                      GestureDetector(
                          child: footerMouseRegion(
                              text: "WORK WITH US", onTap: () {})),
                      SizedBox(height: 17.0),
                      GestureDetector(
                          child: footerMouseRegion(
                              text: "PRIVATE POLICIES", onTap: () {})),
                      SizedBox(height: 17.0),
                      GestureDetector(
                          child: footerMouseRegion(
                              text: "PRESS ENQUIRES", onTap: () {})),
                      SizedBox(height: 17.0),
                      GestureDetector(
                          child: footerMouseRegion(
                              text: "TERMS & CONDITIONS", onTap: () {})),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            '0413-2238675',
                            style: kbottom,
                          ),
                          //padding: EdgeInsets.only(left: 50.0),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                            child: Text(
                          'oceanacademy@gmail.com',
                          style: kbottom,
                        )),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200.0,
                        height: 45,
                        child: TextField(
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          controller: _subscribe,
                          decoration: InputDecoration(
                            hintText: 'Enter your Email',
                            hintStyle: kbottom,
                            contentPadding: EdgeInsets.all(10),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey[200], width: 1.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        // padding: EdgeInsets.only(bottom: 16),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          color: Colors.white,
                          minWidth: 100,
                          height: 50.0,
                          child: Text(
                            "Subscribe",
                            style: TextStyle(fontSize: 15),
                          ),
                          onPressed: () {
                            if (validateEmail(_subscribe.text)) {
                              _firestore
                                  .collection('subscribed user')
                                  .doc(_subscribe.text)
                                  .set({
                                'Email': _subscribe.text,
                              });
                              getData();

                              subscribeDialog(context);
                              _subscribe.clear();
                            } else {
                              subscribeFailedDialog(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 1))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Row(
                        children: [
                          MaterialFlatButton(
                            icon: FontAwesomeIcons.facebookF,
                            onPressed: () {},
                          ),
                          MaterialFlatButton(
                            icon: FontAwesomeIcons.googlePlusG,
                            onPressed: () {},
                          ),
                          MaterialFlatButton(
                            icon: FontAwesomeIcons.linkedinIn,
                            onPressed: () {},
                          ),
                          MaterialFlatButton(
                            icon: FontAwesomeIcons.twitter,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.grey, width: 1))),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  MouseRegion footerMouseRegion({text, onTap}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            child: Text(
              text,
              style: kbottom,
            )),
      ),
    );
  }
}
