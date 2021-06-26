import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabletPurchaseDetails extends StatefulWidget {
  @override
  _TabletPurchaseDetailsState createState() => _TabletPurchaseDetailsState();
}

class _TabletPurchaseDetailsState extends State<TabletPurchaseDetails> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
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
                        /// go back navigation with getX
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
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
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
                          List<TabletPurchaseDB> data = [];

                          for (var message in messages) {
                            final course = message['coursename'];
                            final dbpaidvia = message['paid_via'];
                            final dbpurchaseddate = message['date'];
                            final dbtotalamount = message['amount'];
                            final dbstatus = message['status'];
                            final dbthumbnail = message['image'];
                            final sample = TabletPurchaseDB(
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
      ],
    );
  }
}

// ignore: must_be_immutable
class TabletPurchaseDB extends StatelessWidget {
  TabletPurchaseDB(
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
        SizedBox(height: 25.0),
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 20.0,
                spreadRadius: 5),
          ]),
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: ExpansionTile(
            collapsedBackgroundColor: Colors.grey[50],
            backgroundColor: Colors.grey[100],
            children: [
              Container(
                padding: EdgeInsets.all(25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                "Course Name",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 200,
                              child: Text(course),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              child: Text(
                                "Paid Via",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 200,
                              child: Text(paidvia),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                "Purchased Date",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 200,
                              child: Text(purchaseddate),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 200,
                              child: Text(
                                "Status",
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                            SizedBox(height: 5),
                            Container(
                              width: 200,
                              child: Text(
                                status,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      color: Colors.grey[100],
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 130,
                            child: Text(
                              "Total Amount",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            width: 130,
                            child: Text("₹ $totalamount"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
            title: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    height: 100,
                    width: 160,
                    image: NetworkImage(thumbnail),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 20),
                Text(
                  course,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 25.0),
      ],
    );
  }
}
