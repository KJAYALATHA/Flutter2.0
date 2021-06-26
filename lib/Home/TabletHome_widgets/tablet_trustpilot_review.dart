import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/stars.dart';

class TabletTrustPilotReview extends StatefulWidget {
  @override
  _TabletTrustPilotReviewState createState() => _TabletTrustPilotReviewState();
}

class _TabletTrustPilotReviewState extends State<TabletTrustPilotReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 130,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image(
            image: AssetImage('images/trustpilotReview.png'),
            width: 215,
          ),
          Positioned(
            bottom: 45.0,
            left: 50.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stars(
                  iconColor: Colors.white,
                  containerSize: 30.0,
                  iconBgColor: Colors.green,
                  starRating: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
