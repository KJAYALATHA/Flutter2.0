import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/common/constants.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class JoinSuccessfully extends StatefulWidget {
  JoinSuccessfully({this.joinUserName});
  String joinUserName;
  @override
  _JoinSuccessfullyState createState() => _JoinSuccessfullyState();
}

class _JoinSuccessfullyState extends State<JoinSuccessfully> {
  final valueController = Get.find<ValueListener>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.lightBlue[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Spacer(),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'OCEAN ACADEMY',
                        style: TextStyle(
                            fontSize: 40,
                            fontFamily: kfontname,
                            color: Colors.white),
                      ),
                      Text(
                        'Digital technology',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: kfontname,
                            color: Colors.blue[200]),
                      )
                    ],
                  ),
                ),
                Spacer(
                  flex: 12,
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: kfontname,
                        fontWeight: FontWeight.normal),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(width: 2, color: Colors.white)),
                  onPressed: () {
                    valueController.isFlashNotification.value = true;
                    LoginResponsive.registerNumber != null
                        ? valueController.navebars.value = 'Login'
                        : valueController.navebars.value = 'Home';
                    locator<NavigationService>().navigateTo(LoginResponsive
                                .registerNumber !=
                            null
                        ? '/ClassRoom?userNumber=${LoginResponsive.registerNumber}typeOfCourse=My%20Course'
                        : LoginRoute);
                  },
                ),
                Spacer(),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 30),
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/download%20pdf%20svgs%2Fsend%20link%20email.svg?alt=media&token=320bac9a-f711-4037-b999-617915ac062b'),
                ),
              ),
              Expanded(
                child: Container(
                  height: 600,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            size: 200,
                            color: Colors.white,
                          ),
                          Text(
                            'SUCCESS!',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                inherit: false,
                                color: Colors.white),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            width: 500,
                            child: Text(
                              'Hi ${widget.joinUserName} you have successfully Join our webinar We\'re Sending you join link in your Email',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  inherit: false,
                                  fontFamily: kfontname,
                                  fontWeight: FontWeight.w100),
                            ),
                          ),
                        ],
                      ),
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.lightBlue[900], fontSize: 25),
                          ),
                        ),
                        color: Colors.white,
                        onPressed: () {
                          valueController.isFlashNotification.value = true;
                          LoginResponsive.registerNumber != null
                              ? valueController.navebars.value = 'Login'
                              : valueController.navebars.value = 'Home';
                          locator<NavigationService>().navigateTo(LoginResponsive
                                      .registerNumber !=
                                  null
                              ? '/ClassRoom?userNumber=${LoginResponsive.registerNumber}typeOfCourse=My%20Course'
                              : LoginRoute);

                          // Provider.of<MenuBar>(context, listen: false)
                          //     .updateMenu(widget: NavbarRouting());
                          // Provider.of<Routing>(context, listen: false)
                          //     .updateRouting(widget: Home());
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(),
        ],
      ),
    ));
  }
}
