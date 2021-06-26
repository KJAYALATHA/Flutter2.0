import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/TabletHome_widgets/tablet_trustpilot_review.dart';
import 'package:flutter_app_newocean/Home/TabletHome_widgets/tablet_justdial_review.dart';
import 'package:flutter_app_newocean/Home/TabletHome_widgets/tablet_google_review.dart';

class TabletStarReviews extends StatefulWidget {
  @override
  _TabletStarReviewsState createState() => _TabletStarReviewsState();
}

class _TabletStarReviewsState extends State<TabletStarReviews> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 60,
      runSpacing: 50.0,
      children: [
        TabletJustDialReview(),
        TabletTrustPilotReview(),
        TabletGoogleReview(),
      ],
    );
  }
}
