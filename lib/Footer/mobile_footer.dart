// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/common/material_button.dart';
import 'package:flutter_app_newocean/common/mobile_constents.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;

const kbottom = TextStyle(
    color: Colors.white,
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: kfontname);

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

// ignore: must_be_immutable
class Footer extends StatelessWidget {
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

  TextEditingController _subscribe = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 30.0),
            color: Color(0xFF004478),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'OCEAN ACADEMY',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: kfontname),
                    ),
                  ],
                ),
                SizedBox(
                  height: 18.0,
                ),
                Text(
                  'Ocean was founded on the principle of building and implementing'
                  ' great ideas that drive progress for the students ond clients.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontFamily: kfontname,
                      height: 1.5),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: Text(
                        "HOME",
                        style: kbottom,
                      ),
                      onPressed: () {
                        locator<NavigationService>().navigateTo(HomeRoute);
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                      child: Text(
                        "ABOUT US",
                        style: kbottom,
                      ),
                      onPressed: () {
                        locator<NavigationService>().navigateTo(AboutRoute);
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                      child: Text(
                        "SERVICE",
                        style: kbottom,
                      ),
                      onPressed: () {
                        locator<NavigationService>().navigateTo(ServiceRoute);
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                      child: Text("COURSES", style: kbottom),
                      onPressed: () {
                        locator<NavigationService>().navigateTo(CourseRoute);
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                      child: Text(
                        "CONTACT US",
                        style: kbottom,
                      ),
                      onPressed: () {
                        locator<NavigationService>().navigateTo(ContactUsRoute);
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      '0413-2238675',
                      style: kbottom,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "oceanacademy@gmail.com",
                      style: kbottom,
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 40,
                            width: 170.0,
                            child: TextField(
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                              controller: _subscribe,
                              decoration: InputDecoration(
                                hintText: 'Enter your Email',
                                hintStyle:
                                    TextStyle(fontSize: 13, color: Colors.grey),
                                contentPadding: EdgeInsets.all(5),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[200], width: 1.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Container(
                            child: FlatButton(
                              color: Colors.white,
                              minWidth: 20,
                              height: 48,
                              child: Text("Subscribe"),
                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.all(
                              //         Radius.circular(5.0)),
                              //     side: BorderSide(
                              //       color: Colors.white,
                              //       width: 2.0,
                              //     )),
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
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1))),
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
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 1))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
