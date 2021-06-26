import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:get/get.dart';

class ClassRoomBottomNavigationBar extends StatefulWidget {
  ClassRoomBottomNavigationBar({
    this.iconName,
    this.icon,
    this.onTap,
    this.color,
  });
  IconData icon;
  String iconName;
  Function onTap;
  Color color;

  @override
  _ClassRoomBottomNavigationBarState createState() =>
      _ClassRoomBottomNavigationBarState();
}

class _ClassRoomBottomNavigationBarState
    extends State<ClassRoomBottomNavigationBar> {
  final valueController = Get.find<ValueListener>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            color: widget.color,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(widget.icon, color: Colors.white),
                Text(
                  widget.iconName,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
