import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  @override
  _ErrorPageState createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: Text(
        '404',
        style: TextStyle(fontSize: 150),
      ),
    ));
  }
}
