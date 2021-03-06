import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/common/constants.dart';

class MainTitleWidgetHome extends StatelessWidget {
  final String title;
  MainTitleWidgetHome({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Positioned(
                top: 30,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.centerLeft,
                  width: 800.0,
                  height: 15,
                  color: Colors.grey[200],
                ),
              ),
              Positioned(
                child: Container(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: kfontname,
                      color: textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
