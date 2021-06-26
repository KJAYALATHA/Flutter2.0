import 'package:flutter/material.dart';

class CareerMobile extends StatefulWidget {
  @override
  _CareerMobileState createState() => _CareerMobileState();
}

class _CareerMobileState extends State<CareerMobile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Mobile',
        style: TextStyle(fontSize: 100),
      ),
    );
  }
}
