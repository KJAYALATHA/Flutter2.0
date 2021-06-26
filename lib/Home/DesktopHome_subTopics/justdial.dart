import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/stars.dart';

class JusDialReview extends StatefulWidget {
  @override
  _JusDialReviewState createState() => _JusDialReviewState();
}

class _JusDialReviewState extends State<JusDialReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370.0,
      height: 130.0,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image(
            image: AssetImage('images/jdReview.png'),
            width: 200,
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
