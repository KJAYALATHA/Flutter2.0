import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_newocean/Buttons/border_button.dart';
import 'package:flutter_app_newocean/Extension/Hover_Extension.dart';
import 'package:flutter_app_newocean/alert/alert_text_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

final _firestore = FirebaseFirestore.instance;

class OfflineCourseCard extends StatefulWidget {
  OfflineCourseCard({
    this.coursename,
    this.image,
    this.pdfLink =
        'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/UpcomingCourse%2FPython.png?alt=media&token=6a1562ad-bd87-41a4-898e-0ad3fc470510',
  });
  final String coursename;
  final String pdfLink;
  final String image;

  @override
  _OfflineCourseCardState createState() => _OfflineCourseCardState();
}

class _OfflineCourseCardState extends State<OfflineCourseCard> {
  ConfirmationResult confirmationResult;

  FirebaseAuth _auth = FirebaseAuth.instance;

  UserCredential userCredential;

  final TextEditingController _name = TextEditingController();

  final TextEditingController _mobile = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _otp = TextEditingController();

  void fireStoreAddWithDownload() {
    _firestore.collection('download pdf').doc('+91 ${_mobile.text}').set({
      'name': _name.text,
      'email': _email.text,
      'mobile number': '+91 ${_mobile.text}',
    });
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool isName = true;

  bool isEmail = true;

  bool isNumber = true;
//desktop
  getUserData(context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 600,
              width: 1200,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.grey[500]),
                        iconSize: 30,
                        splashRadius: 25,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: 500,
                            width: 600,
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/download%20pdf%20svgs%2Fmail.svg?alt=media&token=ee065fd0-9616-43b1-9316-f31399fb9442',
                              fit: BoxFit.contain,
                            )),
                        Container(
                          height: 350,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AlertTextField(
                                suffixIcon: isName
                                    ? null
                                    : Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                hintText: 'Name',
                                icon: Icon(Icons.person),
                                controller: _name,
                              ),
                              AlertTextField(
                                suffixIcon: isNumber
                                    ? null
                                    : Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                hintText: 'Mobile',
                                errorText: 'Enter Valid Number',
                                icon: Icon(Icons.phone_android),
                                inputFormatters: [
                                  FilteringTextInputFormatter(
                                      RegExp(r'^\d+\.?\d{0,2}'),
                                      allow: true),
                                ],
                                controller: _mobile,
                              ),
                              AlertTextField(
                                hintText: 'Email',
                                suffixIcon: isEmail
                                    ? null
                                    : Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                icon: Icon(Icons.email),
                                controller: _email,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(0, 2),
                                        blurRadius: 5)
                                  ],
                                  color: Colors.white,
                                ),
                                child: FlatButton(
                                  height: 60.0,
                                  color: Colors.white,
                                  minWidth: 360,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0)),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 30,
                                          height: 30,
                                          child: Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/download%20pdf%20svgs%2Fmail%20service.svg?alt=media&token=49ae698d-0e63-453e-ac4d-f45924d51b9b')),
                                      SizedBox(width: 6),
                                      Text(
                                        'Send to Mail',
                                        style: TextStyle(
                                            fontSize: 20.0, color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    if (validateEmail(_email.text) &&
                                        _mobile.text.length == 10 &&
                                        (_name.text.length > 3)) {
                                      print(_mobile.text);
                                      getDownloadOTP();
                                      Navigator.pop(context);
                                      otpPage(_mobile.text, context);
                                    } else if (_email.text.isEmpty &&
                                        _mobile.text.isEmpty &&
                                        _name.text.isEmpty) {
                                      fillAllFieldsDialog(context);
                                    } else if (_name.text.length < 3) {
                                      invalidNameDialog(context);
                                    } else if (_mobile.text.length != 10) {
                                      invalidNumberDialog(context);
                                    } else if (!validateEmail(_email.text)) {
                                      invalidMailDialog(context);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  otpPage(String userMobileNumber, context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 600,
              width: 1200,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.grey[500]),
                        iconSize: 30,
                        splashRadius: 25,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            height: 500,
                            width: 600,
                            child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/download%20pdf%20svgs%2Fotp%20service.svg?alt=media&token=d5935912-85b6-447d-b495-ef8fbd1de381',
                              fit: BoxFit.contain,
                            )),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AlertTextField(
                                errorText: 'invalid OTP',
                                hintText: 'Enter OTP',
                                icon: Icon(Icons.lock_clock),
                                letterSpacing: 20,
                                controller: _otp,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        offset: Offset(0, 2),
                                        blurRadius: 5)
                                  ],
                                  color: Colors.white,
                                ),
                                child: FlatButton(
                                  height: 60.0,
                                  color: Colors.white,
                                  minWidth: 360,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0)),
                                  child: Row(
                                    children: [
                                      Container(
                                          width: 30,
                                          height: 30,
                                          child: Image.network(
                                              'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/download%20pdf%20svgs%2Fmail%20service.svg?alt=media&token=49ae698d-0e63-453e-ac4d-f45924d51b9b')),
                                      SizedBox(width: 6),
                                      Text(
                                        'submit',
                                        style: TextStyle(
                                            fontSize: 20.0, color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  onPressed: () async {
                                    if (_mobile.text.length >= 10) {
                                      try {
                                        userCredential =
                                            await confirmationResult
                                                .confirm(_otp.text);
                                        print('OTP submited oooppppppp');
                                        getData();
                                        fireStoreAddWithDownload();

                                        Navigator.pop(context);
                                        fieldClear();
                                        mailSendedDialog(context);
                                      } catch (e) {
                                        print('$e OTP faild');
                                        Navigator.pop(context);
                                        _invalidOTP();
                                      }
                                    } else {
                                      Navigator.pop(context);
                                      _invalidOTP();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 20),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.grey[500], fontSize: 15),
                                    children: [
                                      TextSpan(text: 'Not Received OTP'),
                                      TextSpan(
                                          text: ' Update MobileNumber?',
                                          style: TextStyle(color: Colors.blue),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              Navigator.pop(context);
                                              getUserData(context);
                                            }),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

//mobile
  mobileGetUserData(context) {
    return showCupertinoModalPopup(
      barrierColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Text(
                  'Download ${widget.coursename} Pdf',
                  style: TextStyle(fontSize: 35, color: Colors.blue),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AlertTextField(
                      textFieldWidth: MediaQuery.of(context).size.width / 1.5,
                      suffixIcon: isName
                          ? null
                          : Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                      hintText: 'Name',
                      icon: Icon(Icons.person),
                      controller: _name,
                    ),
                    AlertTextField(
                      textFieldWidth: MediaQuery.of(context).size.width / 1.5,
                      suffixIcon: isNumber
                          ? null
                          : Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                      hintText: 'Mobile',
                      errorText: 'Enter Valid Number',
                      icon: Icon(Icons.phone_android),
                      inputFormatters: [
                        FilteringTextInputFormatter(RegExp(r'^\d+\.?\d{0,2}'),
                            allow: true),
                      ],
                      controller: _mobile,
                    ),
                    AlertTextField(
                      textFieldWidth: MediaQuery.of(context).size.width / 1.5,
                      hintText: 'Email',
                      suffixIcon: isEmail
                          ? null
                          : Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                      icon: Icon(Icons.email),
                      controller: _email,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0, 2),
                              blurRadius: 5)
                        ],
                        color: Colors.blueAccent,
                      ),
                      child: FlatButton(
                        height: 60.0,
                        minWidth: MediaQuery.of(context).size.width / 1.5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Container(
                            //     width: 30,
                            //     height: 30,
                            //     child: Image.network(
                            //         'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/download%20pdf%20svgs%2Fmail%20service.svg?alt=media&token=49ae698d-0e63-453e-ac4d-f45924d51b9b')),
                            // SizedBox(width: 6),
                            Text(
                              'Send to Mail',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ],
                        ),
                        onPressed: () async {
                          if (validateEmail(_email.text) &&
                              _mobile.text.length == 10 &&
                              (_name.text.length > 3)) {
                            print(_mobile.text);
                            getDownloadOTP();
                            Navigator.pop(context);
                            mobileOtpPage(_mobile.text, context);
                          } else if (_email.text.isEmpty &&
                              _mobile.text.isEmpty &&
                              _name.text.isEmpty) {
                            fillAllFieldsDialog(context);
                          } else if (_name.text.length < 3) {
                            invalidNameDialog(context);
                          } else if (_mobile.text.length != 10) {
                            invalidNumberDialog(context);
                          } else if (!validateEmail(_email.text)) {
                            invalidMailDialog(context);
                          }
                        },
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0, 2),
                              blurRadius: 5)
                        ],
                        color: Colors.redAccent,
                      ),
                      child: FlatButton(
                        height: 60.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.0)),
                        child: Text(
                          'Close',
                          style: TextStyle(fontSize: 20.0, color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  mobileOtpPage(String userMobileNumber, context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AlertTextField(
                        textFieldWidth: MediaQuery.of(context).size.width / 1.5,
                        errorText: 'invalid OTP',
                        hintText: 'Enter OTP',
                        icon: Icon(Icons.lock_clock),
                        letterSpacing: 20,
                        controller: _otp,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(0, 2),
                                blurRadius: 5)
                          ],
                          color: Colors.blue,
                        ),
                        child: FlatButton(
                          height: 60.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Container(
                              //     width: 30,
                              //     height: 30,
                              //     child: Image.network(
                              //         'https://firebasestorage.googleapis.com/v0/b/ocean-live-project-ea2e7.appspot.com/o/download%20pdf%20svgs%2Fmail%20service.svg?alt=media&token=49ae698d-0e63-453e-ac4d-f45924d51b9b')),
                              // SizedBox(width: 6),
                              Text(
                                'submit',
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ],
                          ),
                          onPressed: () async {
                            if (_mobile.text.length >= 10) {
                              try {
                                userCredential =
                                    await confirmationResult.confirm(_otp.text);
                                print('OTP submited oooppppppp');
                                getData();
                                fireStoreAddWithDownload();

                                Navigator.pop(context);
                                fieldClear();
                                mailSendedDialog(context);
                              } catch (e) {
                                print('$e OTP faild');
                                Navigator.pop(context);
                                _invalidOTP();
                              }
                            } else {
                              Navigator.pop(context);
                              _invalidOTP();
                            }
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(0, 2),
                                blurRadius: 5)
                          ],
                          color: Colors.redAccent,
                        ),
                        child: FlatButton(
                          height: 60.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0)),
                          child: Text(
                            'Close',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 15),
                            children: [
                              TextSpan(text: 'Not Received OTP'),
                              TextSpan(
                                  text: ' Update MobileNumber?',
                                  style: TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      Navigator.pop(context);
                                      MediaQuery.of(context).size.width > 1100
                                          ? getUserData(context)
                                          : mobileGetUserData(context);
                                    }),
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  getDownloadOTP() async {
    confirmationResult =
        await _auth.signInWithPhoneNumber('+91 ${_mobile.text}');
  }

  verifyOTP() async {
    if (_mobile.text.length > 10) {
      try {
        userCredential = await confirmationResult.confirm(_otp.text);
        print(userCredential);
        print(confirmationResult);
        print('OTP submited oooooooo');
        fireStoreAddWithDownload();

        fieldClear();
        Navigator.pop(context);
      } catch (e) {
        print('$e OTP faild');
        Navigator.pop(context);
        _invalidOTP();
      }
    } else {
      Navigator.pop(context);
      _invalidOTP();
    }
  }

  Future<void> _invalidOTP() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(
                'Sorry',
                style: TextStyle(color: Colors.red, fontSize: 20),
              ),
              SizedBox(width: 15),
              Icon(
                FontAwesomeIcons.frown,
                color: Colors.red,
              )
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Enter valid OTP or Update Mobile Number',
                  style: TextStyle(color: Colors.grey[500], fontSize: 25),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Enter OTP'),
              color: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                Navigator.pop(context);
                MediaQuery.of(context).size.width > 1100
                    ? otpPage(_mobile.text, context)
                    : mobileOtpPage(_mobile.text, context);
              },
            ),
            FlatButton(
              child: Text('Update Number'),
              color: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20),
              onPressed: () {
                Navigator.pop(context);
                MediaQuery.of(context).size.width > 1100
                    ? getUserData(context)
                    : mobileGetUserData(context);
              },
            ),
          ],
        );
      },
    );
  }

  fieldClear() {
    _mobile.clear();
    _email.clear();
    _name.clear();
    _otp.clear();
  }

  void getData() async {
    http.Response response = await http.get(Uri(
        path:
            'http://free-webinar-registration.herokuapp.com/?name=${_name.text}&email=${_email.text}&type=syllabus'));
    print('tesss${_name.text}sssssssss${_email.text}sssssssst');

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
    } else {
      print(response.statusCode);
    }
  }

  mailSendedDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.transparent,
          content: Container(
            height: 300,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Mail has been send',
                  style: TextStyle(fontSize: 25, color: Colors.grey[700]),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset('images/043_success-mail.gif'),
              ],
            ),
          ),
        );
      },
    );
  }

  invalidMailDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.transparent,
          content: Container(
            height: 50,
            width: 500,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Invalid E-Mail',
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  invalidNumberDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.transparent,
          content: Container(
            height: 50,
            width: 500,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Invalid Mobile Number',
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  invalidNameDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.transparent,
          content: Container(
            height: MediaQuery.of(context).size.width > 500 ? 50 : 80,
            width: 500,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name should be Greaterthan 3 letter',
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  fillAllFieldsDialog(context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pop(context);
        });
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          backgroundColor: Colors.transparent,
          content: Container(
            height: 50,
            width: 500,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Fill All the Fields',
                  style: TextStyle(fontSize: 25, color: Colors.grey),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
                BorderButton(
                  buttonName: 'Download Pdf',
                  margin: EdgeInsets.symmetric(vertical: 10),
                  hoverColor: Colors.blue[50],
                  buttonWidth: 345,
                  onPressed: () {
                    print(widget.pdfLink);
                    MediaQuery.of(context).size.width > 1100
                        ? getUserData(context)
                        : mobileGetUserData(context);
                  },
                ).moveUpOnHover,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
