import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:url_launcher/url_launcher.dart';

final _firestore = FirebaseFirestore.instance;

class TabletCertificate extends StatefulWidget {
  @override
  _TabletCertificateState createState() => _TabletCertificateState();
}

class _TabletCertificateState extends State<TabletCertificate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        ///Navigation to back screen
                        Get.back();
                        // Provider.of<Routing>(context, listen: false)
                        //     .updateRouting(widget: CoursesView());
                      },
                      child: Icon(Icons.chevron_left,
                          size: 50, color: Colors.blue)),
                  Text('Certificates',
                      style: TextStyle(fontSize: 27, color: Colors.blue)),
                ],
              ),
            ),
            SizedBox(height: 80),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('Certificate').snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading...");
                } else {
                  final messages = snapshot.data.docs;
                  List<CertificateDb> data = [];

                  for (var message in messages) {
                    final dbcourseName = message['courseName'];
                    final dbimage = message['image'];
                    final sample = CertificateDb(
                      image: dbimage,
                      course: dbcourseName,
                    );
                    // Text('$messageText from $messageSender');
                    data.add(sample);
                  }
                  return Wrap(
                    spacing: 50,
                    runSpacing: 30,
                    children: data,
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CertificateDb extends StatefulWidget {
  String image;
  String course;

  CertificateDb({this.image, this.course});

  @override
  _CertificateDbState createState() => _CertificateDbState();
}

class _CertificateDbState extends State<CertificateDb> {
  bool isVisible = false;
  bool isTouching = false;

  launchURL() async {
    final url = '${widget.image}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void mouseEnter(PointerEvent details) {
    setState(() {
      isTouching = true;
    });
  }

  void mouseExit(PointerEvent details) {
    setState(() {
      isTouching = false;
    });
  }

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 0.2),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            child: MouseRegion(
              onEnter: mouseEnter,
              onExit: mouseExit,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          padding: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 10),
                          height: 210,
                          width: 300,
                          child: Image.network('${widget.image}')),
                    ],
                  ),
                  isTouching
                      ? Visibility(
                          child: Center(
                            child: Container(
                              margin: EdgeInsets.only(top: 20),
                              height: 180,
                              width: 300,
                              color: Colors.black54,
                              child: IconButton(
                                iconSize: 60,
                                tooltip: "Download Your Certificate",
                                color: Colors.white,
                                icon: Icon(Icons.download_outlined),
                                onPressed: () {
                                  launchURL();
                                },
                              ),
                            ),
                          ),
                        )
                      : Visibility(
                          visible: isVisible,
                          child: Center(
                            child: Positioned(
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                height: 180,
                                width: 300,
                                // color: Colors.black54,
                                child: IconButton(
                                  iconSize: 60,
                                  tooltip: "Download Your Certificate",
                                  color: Colors.white,
                                  icon: Icon(Icons.download_outlined),
                                  onPressed: () {
                                    launchURL();
                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  '${widget.course} Certificate',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
