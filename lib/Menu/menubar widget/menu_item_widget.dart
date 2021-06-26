import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MenuItemWidget extends StatefulWidget {
  MenuItemWidget({this.title, this.iconData});
  String title;
  IconData iconData;
  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          Icon(
            widget.iconData,
            size: 30,
            color: Colors.grey[700],
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            widget.title,
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          )
        ],
      ),
    );
  }
}
