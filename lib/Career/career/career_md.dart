import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_newocean/Career/career/career_layout.dart';
import 'package:flutter_app_newocean/Footer/desktop_footer_md.dart';

import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;

class CareerMd extends StatefulWidget {
  @override
  _CareerMdState createState() => _CareerMdState();
}

class _CareerMdState extends State<CareerMd> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool validation = false;
  String email;
  void getData() async {
    http.Response response = await http.get(Uri(
        path:
            'http://free-webinar-registration.herokuapp.com/?name=Brinda&email=${CareerLayout.emailController.text}&type=subscribe'));

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  Widget _buildEmail() {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r"\s"))],
      // ignore: deprecated_member_use
      autovalidate: validation,
      validator: (value) =>
          EmailValidator.validate(value) ? null : "please enter a valid email",
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
        border: OutlineInputBorder(),
        hintText: 'Enter Your Email',
        labelText: 'Email',
      ),
      controller: CareerLayout.emailController,
      onChanged: (value) {
        email = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[50],
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 7),
                        child: Text(
                          'We are coming with something',
                          style: TextStyle(fontSize: 23),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 7),
                        child: Text(
                          'AMAZING',
                          style: TextStyle(
                              fontSize: 50,
                              letterSpacing: 5,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: Text(
                          'SUBSCRIBE AND STAY UPDATED',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Row(
                          children: [
                            Container(
                              height: 80,
                              width: 250,
                              child: _buildEmail(),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: 30,
                              ),
                              height: 52,
                              child: FlatButton(
                                color: Colors.blue,
                                padding: EdgeInsets.zero,
                                child: Icon(
                                  Icons.send_outlined,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _firestore
                                        .collection("subscribed user")
                                        .doc(email)
                                        .set({"Email": email});
                                    setState(() {
                                      validation = false;
                                    });
                                    getData();
                                    subscribeDialog(context);
                                    CareerLayout.emailController.clear();
                                  } else {
                                    setState(() {
                                      validation = true;
                                    });
                                    subscribeFailedDialog(context);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 400,
                        // padding: EdgeInsets.only(left: 50),
                        child: Image.asset(
                          'images/coming_soon/Group 11.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: -100,
            left: -200,
            child: ClipPath(
              clipper: LinePathClass(),
              child: Container(
                color: Colors.blue[100],
                height: 200,
                width: 470,
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -215,
            child: ClipPath(
              clipper: LinePathClass(),
              child: Container(
                color: Colors.blue[200],
                height: 220,
                width: 470,
              ),
            ),
          ),
          Positioned(
            bottom: -110,
            right: -120,
            child: ClipPath(
              clipper: LinePathClass(),
              child: Container(
                color: Colors.blue[100],
                height: 200,
                width: 470,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LinePathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // path.moveTo(250, size.height);
    // path.lineTo(0.0, size.height);
    // path.lineTo(size.width, size.height);
    path.moveTo(250, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(250, 0.0);

    //jaya design
    // path.lineTo(0, size.height);
    // path.lineTo(size.width, size.height);
    // path.lineTo(130, 0.0);
    // path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
