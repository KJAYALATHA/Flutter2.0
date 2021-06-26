import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/google_review.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/justdial.dart';
import 'package:flutter_app_newocean/Home/DesktopHome_subTopics/trust_piolet.dart';

class ReView extends StatefulWidget {
  @override
  _ReViewState createState() => _ReViewState();
}

class _ReViewState extends State<ReView> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 50,
      runSpacing: 40.0,
      children: [
        JusDialReview(),
        GoogleReview(),
        TrustPilotReview(),
      ],
    );
  }
}
