import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BorderButton extends StatelessWidget {
  BorderButton(
      {this.onPressed,
      this.buttonName = 'BorderButton',
      this.borderColor = Colors.blue,
      this.borderWidth = 1,
      this.fillColor = Colors.white,
      this.hoverColor = Colors.blue,
      this.textColor = Colors.black,
      this.buttonWidth,
      this.margin,
      this.buttonHeight = 45,
      this.textStyle,
      this.borderRadius = 1});
  Function onPressed;
  String buttonName;
  double borderWidth;
  double buttonWidth;
  Color fillColor;
  Color borderColor;
  Color hoverColor;
  Color textColor;
  EdgeInsets margin;
  double buttonHeight;
  TextStyle textStyle;
  double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: FlatButton(
          hoverColor: hoverColor,
          height: buttonHeight,
          minWidth: buttonWidth,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor, width: borderWidth),
          ),
          color: fillColor,
          onPressed: onPressed,
          child: Text(
            buttonName,
            style: textStyle,
          )),
    );
  }
}
