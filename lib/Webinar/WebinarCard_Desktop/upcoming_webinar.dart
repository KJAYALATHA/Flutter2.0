import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Webinar/WebinarCard_Desktop/webinar_list.dart';

class UpcomingWebinar extends StatefulWidget {
  @override
  _UpcomingWebinarState createState() => _UpcomingWebinarState();
}

class _UpcomingWebinarState extends State<UpcomingWebinar> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Center(
        child: WebinarCard(),
      ),
    );
  }
}
