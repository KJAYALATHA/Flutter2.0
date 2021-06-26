import 'dart:ui';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_codes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/Login/Login_View/otp.dart';

import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';

class MobileLogin extends StatefulWidget {
  @override
  _MobileLoginState createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {
  bool isNumValid = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController _phoneNumberController = TextEditingController();
  String countryCode;
  List<Map<String, String>> contri = codes;
  bool rememberMe = false;
  String phoneNumber;

  getOTP() async {
    LoginResponsive.confirmationResult = await auth.signInWithPhoneNumber(
        '${countryCode.toString()} ${_phoneNumberController.text}');
    LoginResponsive.registerNumber =
        '${countryCode.toString()} ${_phoneNumberController.text}';
    print("${LoginResponsive.confirmationResult}LogIn.confirmationResult");
  }

  List getContryCode() {
    List<String> contryCode = [];
    for (var cCode in contri) {
      contryCode.add(cCode['code']);
    }
    return contryCode;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff006793),
        image: DecorationImage(
          image: AssetImage('images/login_bg3.png'),
          fit: BoxFit.cover,
          alignment: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome Back',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width - 50,
                // margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                decoration: BoxDecoration(
                    // color: Colors.white,
                    border: Border.all(color: Colors.white, width: 3),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.0)),
                child: CountryCodePicker(
                  backgroundColor: Colors.transparent,
                  onChanged: print,
                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                  initialSelection:
                      getContryCode()[getContryCode().indexOf('IN')],
                  countryFilter: getContryCode(),
                  showFlagDialog: true,
                  showDropDownButton: true,
                  dialogBackgroundColor: Colors.white,

                  hideSearch: true,
                  dialogSize: Size(300.0, 550.0),
                  onInit: (code) {
                    countryCode = '+91';
                    print('${countryCode.toString()}countryCode.toString()');
                  },

                  dialogTextStyle: TextStyle(color: Colors.blue),
                  enabled: true,
                  boxDecoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 70.0,
                width: MediaQuery.of(context).size.width - 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50.0,
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(3.0),
                          border: Border.all(color: Colors.white, width: 3)),
                      child: TextField(
                        cursorColor: Colors.white,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        decoration: InputDecoration(
                            hintText: 'Enter Valid Mobile Number',
                            hintStyle: TextStyle(color: Colors.white),
                            filled: true,
                            fillColor: Colors.transparent,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: isNumValid
                                  ? Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.send_to_mobile,
                                      color: Colors.white,
                                    ),
                              onPressed: () async {
                                if (isNumValid) {
                                  setState(() {
                                    _phoneNumberController.text = '';
                                    isNumValid = false;
                                  });
                                } else {
                                  print(
                                      "${_phoneNumberController.text}_phoneNumberController.text");
                                  setState(() {
                                    //Navbar.visiblity = false;
                                    OTP.userID =
                                        '${countryCode.toString()} ${_phoneNumberController.text}';
                                    // MenuBar.stayUser = OTP.userID;
                                  });

                                  if (_phoneNumberController.text.length >=
                                      10) {
                                    //getData();

                                    ///todo remove the hide get otp
                                    //session();

                                    //
                                    // Provider.of<Routing>(context,
                                    //         listen: false)
                                    //     .updateRouting(
                                    //         widget: OTP(
                                    //   confirmationResult: confirmationResult,
                                    // ));
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => OTP(
                                    //               confirmationResult:
                                    //                   confirmationResult,
                                    //             )));
                                    await getOTP();

                                    locator<NavigationService>()
                                        .navigateTo(OTPRoute);
                                  } else {
                                    isNumValid = true;
                                  }
                                }
                              },
                            )),
                        keyboardType: TextInputType.phone,
                        controller: _phoneNumberController,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d+\.?\d{0,1}')),
                          LengthLimitingTextInputFormatter(13),
                        ],
                        onChanged: (value) {
                          setState(() {
                            phoneNumber = value;
                          });
                        },
                      ),
                    ),
                    Visibility(
                        visible: isNumValid,
                        child: Text(
                          'Enter valid PhoneNumber',
                          style: TextStyle(color: Colors.red, fontSize: 15.0),
                        )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RawMaterialButton(
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5.0)),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    width: MediaQuery.of(context).size.width - 50,
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xff006793),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  elevation: 1,
                  hoverElevation: 0,
                  hoverColor: Colors.grey[200],
                  fillColor: Colors.white,
                  onPressed: () async {
                    print(
                        "${_phoneNumberController.text}_phoneNumberController.text");
                    setState(() {
                      //Navbar.visiblity = false;
                      OTP.userID =
                          '${countryCode.toString()} ${_phoneNumberController.text}';
                      // MenuBar.stayUser = OTP.userID;
                    });

                    if (_phoneNumberController.text.length >= 10) {
                      //getData();

                      ///todo remove the hide get otp
                      //session();

                      //
                      // Provider.of<Routing>(context,
                      //         listen: false)
                      //     .updateRouting(
                      //         widget: OTP(
                      //   confirmationResult: confirmationResult,
                      // ));
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => OTP(
                      //               confirmationResult:
                      //                   confirmationResult,
                      //             )));
                      await getOTP();

                      locator<NavigationService>().navigateTo(OTPRoute);
                    } else {
                      isNumValid = true;
                    }
                  }),
            ],
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width / 1.4,
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.white, width: 1),
          //   ),
          //   child: TextField(
          //     decoration: InputDecoration(
          //         hintText: 'Enter Valid Mobile Number',
          //         hintStyle: TextStyle(color: Colors.grey[500]),
          //         filled: true,
          //         fillColor: Colors.white,
          //         enabledBorder: InputBorder.none,
          //         focusedBorder: InputBorder.none,
          //         border: InputBorder.none,
          //         disabledBorder: InputBorder.none,
          //         suffixIcon: IconButton(
          //           icon: Icon(
          //             Icons.arrow_forward_ios,
          //             color: Colors.blue,
          //           ),
          //         )),
          //   ),
          // )
        ],
      ),
    );
  }
}
