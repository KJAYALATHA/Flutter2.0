import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/main_title_widget.dart';
import 'package:flutter_app_newocean/common/comments.dart';
import 'package:flutter_app_newocean/common/text.dart';

class OurClient extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              MainTitleWidgetHome(
                title: "Our Clients",
              ),
              SizedBox(
                height: 40.0,
              ),
              TextWidget(
                title: clientcontent,
              ),
            ],
          ),
          SizedBox(
            height: 100.0,
          ),
          Wrap(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('Client').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  } else {
                    final messages = snapshot.data.docs;
                    List<CollegeLogo> collegeLogo = [];

                    for (var message in messages) {
                      final logoImage = message['Client'];
                      final logos = CollegeLogo(
                        collegeLogoImage: logoImage,
                      );
                      // Text('$messageText from $messageSender');
                      collegeLogo.add(logos);
                    }
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 70),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 70.0,
                        runSpacing: 30,
                        children: collegeLogo,
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CollegeLogo extends StatelessWidget {
  final String collegeLogoImage;
  CollegeLogo({this.collegeLogoImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: NetworkImage("$collegeLogoImage"),
        width: 110.0,
        // fit: BoxFit.fitWidth,
      ),
    );
  }
}
