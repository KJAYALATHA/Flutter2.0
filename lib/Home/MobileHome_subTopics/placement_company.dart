import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/MobileHome_subTopics/main_title_widget.dart';
import 'package:flutter_app_newocean/common/comments.dart';
import 'package:flutter_app_newocean/common/mobile_constents.dart';
import 'package:flutter_app_newocean/common/text.dart';

class PlacementCompany extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              MainTitleWidget(
                title: "Our student got placement",
              ),
              TextWidget(
                title: placementcontent,
                style: TextStyle(
                    fontFamily: kfontname, color: kcontentcolor, height: 1.5),
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
          Wrap(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('placement').snapshots(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Text("Loading...");
                  } else {
                    final messages = snapshot.data.docs;
                    List<CompanyLogo> companyLogo = [];

                    for (var message in messages) {
                      final logoImage = message['img'];
                      final logos = CompanyLogo(
                        companyLogoImage: logoImage,
                      );
                      // Text('$messageText from $messageSender');
                      companyLogo.add(logos);
                    }
                    return Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 30.0,
                      //runSpacing: 0.0,
                      children: companyLogo,
                    );
                  }
                },
              ),
            ],
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      ),
    );
  }
}

class CompanyLogo extends StatelessWidget {
  final String companyLogoImage;
  CompanyLogo({this.companyLogoImage});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage("$companyLogoImage,"),
      width: 60.0,
    );
  }
}
