import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/stars.dart';

class TabletGoogleReview extends StatefulWidget {
  @override
  _TabletGoogleReviewState createState() => _TabletGoogleReviewState();
}

class _TabletGoogleReviewState extends State<TabletGoogleReview> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 220,
        height: 100.0,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              child: Image(
                image: AssetImage('images/googleReview.png'),
                width: 150,
              ),
            ),
            Positioned(
              bottom: 5.0,
              right: -5.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stars(
                    containerSize: 30,
                    iconColor: Colors.green,
                    starRating: 5,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
