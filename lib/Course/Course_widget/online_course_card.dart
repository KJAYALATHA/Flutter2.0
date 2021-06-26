import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Buttons/border_button.dart';
import 'package:flutter_app_newocean/Extension/Hover_Extension.dart';

// ignore: must_be_immutable
class OnlineCourseCard extends StatefulWidget {
  static bool visiblity = false;
  OnlineCourseCard(
      {this.coursename,
      this.trainername,
      this.duration,
      this.time,
      this.date,
      this.onPressed,
      this.image,
      this.description,
      this.batchid});
  final String coursename;
  final String trainername;
  final String duration;
  final String time;
  final String image;
  final String description;
  final String batchid;
  final String date;
  Function onPressed;

  @override
  _OnlineCourseCardState createState() => _OnlineCourseCardState();
}

class _OnlineCourseCardState extends State<OnlineCourseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      //padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      //  height: 375.0,
      width: 350.0,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                '${widget.image}',
                fit: BoxFit.fitWidth,
                alignment: Alignment.centerLeft,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "${widget.coursename} full package course",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[600],
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Trainer ${widget.trainername}",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey[600],
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Color(0xff3B7EB6),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${widget.duration} Hrs",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey[600],
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.date_range,
                              color: Color(0xff3B7EB6),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${widget.date} ",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey[600],
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Color(0xff3B7EB6),
                            ),
                            SizedBox(width: 5),
                            Text(
                              "${widget.time}",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.grey[600],
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                BorderButton(
                        buttonName: 'View Detail',
                        margin: EdgeInsets.symmetric(vertical: 10),
                        hoverColor: Colors.blue[50],
                        buttonWidth: 345,
                        onPressed: widget.onPressed)
                    .moveUpOnHover,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
