// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/ClassRoom/CourseView/desktop_classroom/desktop_CourseView.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_newocean/payment/ui_payment.dart'
    if (dart.library.html) 'dart:ui' as ui;

// ignore: must_be_immutable
class MobileRazorPay extends StatefulWidget {
  String courseName;
  String amount;
  List course;
  String courseImage;
  List batchid;
  String studentname;
  String studentemail;

  MobileRazorPay(
      {this.amount,
      this.course,
      this.courseName,
      this.courseImage,
      this.batchid});
  @override
  _MobileRazorPayState createState() => _MobileRazorPayState();
}

class _MobileRazorPayState extends State<MobileRazorPay> {
  var date;
  final _firestore = FirebaseFirestore.instance;
  TextEditingController rupees = TextEditingController(text: '5');
  TextEditingController email = TextEditingController();
  TextEditingController name;
  TextEditingController mobilenumber;
  session() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('login', 1);
    await prefs.setString('user', LoginResponsive.registerNumber);
    print('Otp Submited');
    print('000000000000');
    print(LoginResponsive.registerNumber);
  }

  // TextEditingController duration = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    session();
    var test = DateTime.now();
    date = (DateFormat("dd-MM-y").format(test));
    print(date);
    name = TextEditingController(text: CoursesView.courseEnroll);
    mobilenumber = TextEditingController(text: CoursesView.courseEnroll);
    print("${CoursesView.courseEnroll}priyeee");
    print("${CoursesView.studentemail}priyeee");
  }

  @override
  Widget build(BuildContext context) {
    print("=======================");
    print(LoginResponsive.registerNumber);
    print(widget.amount);
    ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
      IFrameElement element = IFrameElement();
      //Event Listener
      window.onMessage.forEach((element) {
        print('Event Received in callback: ${element.data}');
        print('PAYMENT  FAILURE!!!!!!!   ${element.data}');
        if (element.data == 'MODAL_CLOSED') {
          // Navigator.pop(context);
          print('PAYMENT FAILURE!!!!!!!');
        } else if (element.data == 'SUCCESS') {
          print('PAYMENT SUCCESSFULL!!!!!!!');
          print('${widget.course} ');
          print('${widget.batchid} ');
          print('${LoginResponsive.registerNumber} ');
          _firestore
              .collection("new users")
              .doc(LoginResponsive.registerNumber)
              .update({
            "Courses": FieldValue.arrayUnion(widget.course),
            "batchid": FieldValue.arrayUnion(widget.batchid),
            "text": "jaya"
          });

          _firestore
              .collection("new users")
              .doc(LoginResponsive.registerNumber)
              .collection("payment")
              .doc(widget.courseName)
              .set({
            "coursename": widget.courseName,
            "amount": widget.amount,
            "date": date,
            "image": widget.courseImage,
            "paid_via": "debit card",
            "status": "Completed",
          });
          print('${widget.course} wwwwwwwwwwwwwwwwwwwFirsttttt');
          // Provider.of<SyllabusView>(context, listen: false)
          //     .updateCourseSyllabus(routing: ThanksForPurchasing());
          // Provider.of<MenuBar>(context, listen: false)
          //     .updateMenu(widget: AppBarWidget());
          locator<NavigationService>().navigateTo(ThanksForPurchase);
          print('PAYMENT SUCCESSFULL !!!!!!!');
        }
      });

      element.requestFullscreen();

      /// todo amount int.parse(widget.amount)
      // element.height="650px";
      // element
      element.srcdoc = """ <!DOCTYPE html><html>

<meta name="viewport" content="width=device-width, initial-scale=0.5">
<head><title>RazorPay Web Payment</title></head>

<body>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>

       var options = {
         "key": "rzp_live_yI4lHyiI5FRJWt",
          "amount": "${1 * 100}", "currency": "INR",
          "name": "${CoursesView.courseEnroll}",
          "description": "Online Payment Transaction",
          "image": "https://example.com/your_logo",
          "handler": function (response){
             window.parent.postMessage("SUCCESS","*");      //2
            
          },
          "prefill": {
             "name": "${CoursesView.courseEnroll}",
             "email": "${CoursesView.studentemail}",
             "contact": "${LoginResponsive.registerNumber}"
           },
           "notes": {
             "address": "Autofy"
          },
        
          "modal": {
            "ondismiss": function(){
               //window.parent.postMessage("MODAL_CLOSED","*");   //3
            }
          }
       };

       var rzp1 = new Razorpay(options);
       
       window.onload = function(e){  //1
       
          rzp1.open();
           e.preventDefault();
          
       }
       
      

     </script>
     
<style>


</style>

</body>
</html> """;

      element.style.border = 'none';

      return element;
    });
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height / 1.4,
              width: MediaQuery.of(context).size.width / 1.2,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 6),
              ]),
              child: HtmlElementView(
                viewType: 'rzp-html',
              ),
            ),
          ],
        ));
  }
}
