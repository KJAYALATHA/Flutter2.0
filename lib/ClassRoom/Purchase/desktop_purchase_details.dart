import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:get/get.dart';

class DesktopPurchaseDetails extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),
            Row(
              children: [
                SizedBox(width: 5),
                Tooltip(
                  message: 'Go back',
                  child: IconButton(
                    icon: Icon(
                      Icons.chevron_left,
                    ),
                    color: Colors.blue,
                    iconSize: 50,
                    splashRadius: 30,
                    onPressed: () {
                      Get.back();
                      // Provider.of<Routing>(context, listen: false)
                      //     .updateRouting(widget: CoursesView());
                    },
                  ),
                ),
                Text(
                  'Purchases',
                  style: TextStyle(
                      fontSize: 25,
                      color: Color(0xff2B9DD1),
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80),
              child: Column(
                children: [
                  Container(
                    child: Divider(
                      thickness: 0.1,
                      color: Colors.black26,
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 110,
                          child: Text(
                            'Thumbnail',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 170,
                          child: Text(
                            'Course Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 120,
                          child: Text(
                            'Purchased Date',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 120,
                          child: Text(
                            'Total Amount',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 120,
                          child: Text(
                            'Paid Via',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 120,
                          child: Text(
                            'Status',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Divider(
                      thickness: 0.1,
                      color: Colors.black26,
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    ///todo update doc
                    stream: _firestore
                        .collection('new users')
                        .doc(LoginResponsive.registerNumber)
                        .collection("payment")
                        .snapshots(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text("Loading...");
                      } else {
                        final messages = snapshot.data.docs;
                        List<Purchasedatabase> data = [];

                        for (var message in messages) {
                          final course = message['coursename'];
                          final dbpaidvia = message['paid_via'];
                          final dbpurchaseddate = message['date'];
                          final dbtotalamount = message['amount'];
                          final dbstatus = message['status'];
                          final dbthumbnail = message['image'];
                          final sample = Purchasedatabase(
                            course: course,
                            paidvia: dbpaidvia,
                            purchaseddate: dbpurchaseddate,
                            totalamount: dbtotalamount,
                            status: dbstatus,
                            thumbnail: dbthumbnail,
                          );
                          // Text('$messageText from $messageSender');
                          data.add(sample);
                          print(data);
                        }
                        return Column(
                          children: data,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Purchasedatabase extends StatelessWidget {
  Purchasedatabase(
      {this.course,
      this.paidvia,
      this.purchaseddate,
      this.status,
      this.thumbnail,
      this.totalamount});

  String course;
  String paidvia;
  String purchaseddate;
  String status;
  String thumbnail;
  String totalamount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.center,
              width: 110,
              child: Image.network(
                "$thumbnail",
                height: 40,
                width: 40,
              ),
            ),
            Container(
                alignment: Alignment.center,
                width: 170,
                child: Text('$course')),
            Container(
                alignment: Alignment.center,
                width: 120,
                child: Text('$purchaseddate')),
            Container(
                alignment: Alignment.center,
                width: 120,
                child: Text('$totalamount')),
            Container(
                alignment: Alignment.center,
                width: 120,
                child: Text('$paidvia')),
            Container(
                alignment: Alignment.center,
                width: 120,
                child: Text('$status')),
          ],
        ),
        Container(
          child: Divider(
            thickness: 0.1,
            color: Colors.black26,
          ),
        ),
      ],
    );
  }
}
