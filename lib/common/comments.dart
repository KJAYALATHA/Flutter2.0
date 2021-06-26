import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/common/constants.dart';

class TextWidget extends StatelessWidget {
  final String title;
  final TextStyle style;
  TextWidget({this.title, this.style = otherSmallContentTextStyle});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width -
            MediaQuery.of(context).size.width / 10,
        child: Text(
          title,
          style: style,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
