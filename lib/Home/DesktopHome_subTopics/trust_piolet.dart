import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/stars.dart';

class TrustPilotReview extends StatefulWidget {
  @override
  _TrustPilotReviewState createState() => _TrustPilotReviewState();
}

class _TrustPilotReviewState extends State<TrustPilotReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370.0,
      height: 130,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image(
            image: AssetImage('images/trustpilotReview.png'),
            width: 250,
          ),
          Positioned(
            bottom: 40.0,
            left: 120.0,
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
