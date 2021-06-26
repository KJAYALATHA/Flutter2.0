import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_newocean/Career/career/career_layout.dart';
import 'package:flutter_app_newocean/Footer/tablet_footer.dart';
import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;

class TabCareer extends StatefulWidget {
  @override
  _TabCareerState createState() => _TabCareerState();
}

class _TabCareerState extends State<TabCareer> {
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
        contentPadding: EdgeInsets.all(3),
        labelStyle: TextStyle(fontSize: 12),
        hintStyle: TextStyle(fontSize: 12),
        prefixIcon: Icon(Icons.email_outlined),
        errorStyle: TextStyle(color: Colors.redAccent, fontSize: 0),
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
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.blue[50],
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 250,
                      child: Image.asset(
                        'images/coming_soon/Group 11.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: 7),
                            child: Text(
                              'We are coming with something',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, bottom: 7),
                            child: Text(
                              'AMAZING',
                              style: TextStyle(
                                  fontSize: 40,
                                  letterSpacing: 5,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 30),
                            child: Text(
                              'SUBSCRIBE AND STAY UPDATED',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 70,
                        width: 250,
                        child: _buildEmail(),
                      ),
                      SizedBox(width: 15),
                      Container(
                        margin: EdgeInsets.only(bottom: 21),
                        height: 46,
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
                SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            bottom: -150,
            left: -220,
            child: ClipPath(
              clipper: LinePathClass(),
              child: Container(
                color: Colors.blue[200],
                height: 250,
                width: 450,
              ),
            ),
          ),
          Positioned(
            bottom: -120,
            right: -170,
            child: ClipPath(
              clipper: LinePathClass(),
              child: Container(
                color: Colors.blue[200],
                height: 250,
                width: 420,
              ),
            ),
          ),
          Positioned(
            bottom: -160,
            right: -100,
            child: ClipPath(
              clipper: LinePathClass(),
              child: Container(
                color: Colors.blue[100],
                height: 250,
                width: 420,
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
    path.moveTo(250, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(250, 0.0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
