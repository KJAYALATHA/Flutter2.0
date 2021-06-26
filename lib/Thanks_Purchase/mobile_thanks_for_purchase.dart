import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/Login/Login_View/otp.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileThanksForPurchasing extends StatefulWidget {
  @override
  _MobileThanksForPurchasingState createState() =>
      _MobileThanksForPurchasingState();
}

class _MobileThanksForPurchasingState extends State<MobileThanksForPurchasing> {
  @override
  void initState() {
    // TODO: implement initState
    getSession();
    super.initState();
  }

  @override
  final valueController = Get.find<ValueListener>();
  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginResponsive.registerNumber = (prefs.getString('user') ?? null);
    print("thanks for ${LoginResponsive.registerNumber}");
    print("thanks for ${OTP.userID}");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xfff7f7f7),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Thanks for purchasing!',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(height: 30),
              Container(
                  alignment: Alignment.center,
                  height: 150,
                  child: Image.asset("images/thanksforpurchase.gif")),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text('Your payment has been made successfully',
                    style: TextStyle(fontSize: 15, color: Color(0xff333333))),
              ),
              SizedBox(height: 40),
              Container(
                height: 50,
                width: 160,
                child: OutlineButton(
                  borderSide: BorderSide(color: Colors.blue),
                  // color: Color(0xff0091D2),
                  onPressed: () {
                    locator<NavigationService>().navigateTo(
                        '/ClassRoom?userNumber=${LoginResponsive.registerNumber}&typeOfCourse=${valueController.courseType.value}');
                  },
                  child: Text(
                    "Go to Courses",
                    style: TextStyle(color: Colors.blue, fontSize: 18),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
