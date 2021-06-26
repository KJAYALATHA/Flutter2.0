import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SyllabusList extends StatefulWidget {
  SyllabusList(
      {this.title,
      this.subTitle,
      this.dayFormat,
      this.monthFormatString,
      this.onPressed,
      this.hourFormat,
      this.minuteFormat,
      this.timing,
      this.zoomLink,
      this.zoomPassword,
      this.mainColor,
      this.status,
      this.secondaryColor,
      this.duration});
  String title;
  String duration;
  String status;
  Color mainColor = Color(0xff0B74EF);
  Color secondaryColor = Color(0xff00A3FF);
  String subTitle;
  String zoomLink;
  String zoomPassword;
  int dayFormat;
  int hourFormat;
  int minuteFormat;
  String timing;
  String monthFormatString;
  Function onPressed;
  @override
  _SyllabusListState createState() => _SyllabusListState();
}

class _SyllabusListState extends State<SyllabusList> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, screenSize) {
      if (screenSize.maxWidth > 951) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5,
              )
            ],
          ),
          height: 200,
          width: MediaQuery.of(context).size.width / 1.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    colors: [widget.mainColor, widget.secondaryColor],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        '${widget.hourFormat}:${widget.minuteFormat} ${widget.timing}',
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          '${widget.dayFormat}',
                          style: TextStyle(
                              height: 0.8,
                              fontSize: 80,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          '${widget.monthFormatString}',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 500,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            '${widget.title}',
                            style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Roboto',
                                inherit: false,
                                fontWeight: FontWeight.w800,
                                color: Colors.grey[700]),
                          ),
                          Text(
                            '${widget.subTitle}',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                inherit: false,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[500]),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              '${widget.duration} Minutes',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.video_call_sharp),
                            iconSize: 50,
                            color: widget.mainColor,
                            onPressed: widget.onPressed,
                          ),
                          Text(
                            '${widget.status}',
                            style: TextStyle(
                                fontSize: 20,
                                color: widget.mainColor,
                                height: 1),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 20,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [widget.secondaryColor, widget.mainColor],
                )),
              ),
            ],
          ),
        );
      } else if (screenSize.maxWidth > 601) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 5,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomRight,
                    colors: [widget.mainColor, widget.secondaryColor],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${widget.dayFormat}',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${widget.monthFormatString}',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '${widget.hourFormat}:${widget.minuteFormat} ${widget.timing}',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                    Spacer(),
                    Text(
                      '${widget.duration} Minutes',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.title}',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Roboto',
                              inherit: false,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey[700]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${widget.subTitle}',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              inherit: false,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey[500]),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.video_call_sharp),
                          iconSize: 50,
                          color: widget.mainColor,
                          onPressed: widget.onPressed,
                        ),
                        Text(
                          widget.status,
                          style: TextStyle(
                              fontSize: 20, color: widget.mainColor, height: 1),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 20,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: FractionalOffset.topLeft,
                  end: FractionalOffset.bottomRight,
                  colors: [widget.secondaryColor, widget.mainColor],
                )),
              ),
            ],
          ),
        );
      } else {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight,
                        colors: [widget.mainColor, widget.secondaryColor],
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.dayFormat}',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${widget.monthFormatString}',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          '  |  ',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          '${widget.hourFormat}:${widget.minuteFormat} ${widget.timing}',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.normal),
                        ),
                        Spacer(),
                        Text(
                          '${widget.duration} Min',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 15),
                            Text(
                              '${widget.title}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: 'Roboto',
                                  inherit: false,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.grey[700]),
                            ),
                            SizedBox(height: 20),
                            Text(
                              '${widget.subTitle}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Roboto',
                                  inherit: false,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey[500]),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                          begin: FractionalOffset.topLeft,
                          end: FractionalOffset.bottomRight,
                          colors: [widget.secondaryColor, widget.mainColor],
                        )),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // IconButton(
                            //   icon: Icon(Icons.video_call_sharp),
                            //   iconSize: 40,
                            //   color: Colors.white,
                            //   onPressed: widget.onPressed,
                            // ),
                            Icon(
                              Icons.video_call_sharp,
                              size: 35,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.status,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.white, height: 1),
                            ),
                          ],
                        )),
                    onTap: widget.onPressed,
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[400],
                    width: 0.8,
                  ),
                ),
              ),
            )
          ],
        );
      }
    });
  }
}
