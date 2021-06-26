import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileItems extends StatelessWidget {
  double bottonRadius;
  double topRadius;
  Function onPressed;
  IconData icon;
  String label;
  Color iconColor;
  Color textColor;
  ProfileItems({
    this.topRadius = 0,
    this.bottonRadius = 0,
    this.onPressed,
    this.icon,
    this.label,
    this.textColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(topRadius),
            bottom: Radius.circular(bottonRadius)),
        color: Colors.white,
      ),
      // width: 50,
      // height: 50,
      child: FlatButton(
          padding: EdgeInsets.only(left: 60),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              SizedBox(width: 10),
              Text(
                '$label',
                style: TextStyle(color: textColor),
              ),
            ],
          ),
          onPressed: onPressed),
    );
  }
}
