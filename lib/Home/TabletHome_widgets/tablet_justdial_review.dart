import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/stars.dart';

class TabletJustDialReview extends StatefulWidget {
  @override
  _TabletJustDialReviewState createState() => _TabletJustDialReviewState();
}

class _TabletJustDialReviewState extends State<TabletJustDialReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 100.0,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image(
            image: AssetImage('images/jdReview.png'),
            width: 130,
          ),
          Positioned(
            bottom: 30.0,
            // right: 0.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Stars(
                  iconColor: Colors.orange,
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
