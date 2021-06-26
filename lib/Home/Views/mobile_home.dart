import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Footer/mobile_footer.dart';
import 'package:flutter_app_newocean/Home/MobileHome_subTopics/how_it_works.dart';
import 'package:flutter_app_newocean/Home/MobileHome_subTopics/main_badget_widget.dart';
import 'package:flutter_app_newocean/Home/MobileHome_subTopics/placement_company.dart';
import 'package:flutter_app_newocean/Home/MobileHome_subTopics/reviews.dart';
import 'package:flutter_app_newocean/Home/MobileHome_subTopics/slider_widget.dart';
import 'package:flutter_app_newocean/Home/MobileHome_subTopics/upcoming_course_widget.dart';
import 'package:flutter_app_newocean/Menu/Menu_DeskTop.dart';
import 'package:flutter_app_newocean/alert/bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class MobileHome extends StatefulWidget {
  MobileHome({this.appBar});
  final AppBar appBar;

  @override
  _MobileHomeState createState() => _MobileHomeState();
}

class _MobileHomeState extends State<MobileHome> {
  GlobalKey<FormState> formKeyAlert = GlobalKey<FormState>();

  final keyIsFirstLoaded = 'is_first_loaded';

  String fullNameAlert;

  String phoneNumberAlert;

  String emailAlert;

  bool flag = true;

  GlobalKey<ScaffoldState> homeScaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    menu.updateAll((key, value) => menu[key] = false);
    menu['Home'] = true;
    super.initState();
    Future.delayed(
        Duration(seconds: 3), () => showDialogIfFirstLoaded(context));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SliderWidget(),
            MainBadgeWidget(),
            UpcomingCourse(),
            PlacementCompany(),
            ReviewsSection(),
            HowItWorks(),
            Footer(),
          ],
        ),
      ),
    );
  }

  Future showDialogIfFirstLoaded(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstLoaded = prefs.getBool(keyIsFirstLoaded);

    /// TODO insted of true = null
    if (isFirstLoaded == true) {
      showCupertinoModalPopup(
        barrierColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return MobileBottomSheet(
            keyIsFirstLoaded: keyIsFirstLoaded,
          );
        },
      );
    }
  }
}
