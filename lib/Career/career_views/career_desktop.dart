import 'package:flutter/material.dart';

class CareerDesktop extends StatefulWidget {
  @override
  _CareerDesktopState createState() => _CareerDesktopState();
}

class _CareerDesktopState extends State<CareerDesktop> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Desktop',
        style: TextStyle(fontSize: 100),
      ),
    );
  }
}
