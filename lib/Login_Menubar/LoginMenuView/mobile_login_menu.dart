import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Landing/Home_view.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';

final _firestore = FirebaseFirestore.instance;

class MobileLoginMenu extends StatefulWidget {
  @override
  _MobileLoginMenuState createState() => _MobileLoginMenuState();
}

class _MobileLoginMenuState extends State<MobileLoginMenu> {
  GlobalKey<ScaffoldState> classRoomKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  scaffoldKey.currentState.openDrawer();
                }),
            // Container(
            //   width: 40,
            //   height: 40,
            //   decoration: BoxDecoration(
            //     shape: BoxShape.circle,
            //     color: Colors.pink,
            //     image:
            //         DecorationImage(image: AssetImage('images/exProfile.png')),
            //   ),
            // ),
            //  PopupMenuButton(itemBuilder: ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('new users').snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading...");
                } else {
                  final messages = snapshot.data.docs;

                  String profileImage;
                  for (var message in messages) {
                    // var id = valueController.userNumber.value != null
                    //     ? MenuBar.stayUser
                    //     : LogIn.registerNumber;
                    if (message.id == LoginResponsive.registerNumber) {
                      profileImage = message['Profile Picture'];
                    }
                  }
                  return GestureDetector(
                    onTap: () {
                      scaffoldKey.currentState.openEndDrawer();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                        image: DecorationImage(
                            image: NetworkImage('$profileImage'),
                            fit: BoxFit.cover),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ));
  }
}
