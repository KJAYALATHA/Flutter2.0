import 'package:flutter/material.dart';

class CareerTab extends StatefulWidget {
  @override
  _CareerTabState createState() => _CareerTabState();
}

class _CareerTabState extends State<CareerTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tab',
        style: TextStyle(fontSize: 100),
      ),
    );
  }
}
