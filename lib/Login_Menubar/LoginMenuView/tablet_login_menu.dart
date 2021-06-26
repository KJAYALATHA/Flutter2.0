import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Buttons/pop_up_menu_botton_custamize.dart';
import 'package:flutter_app_newocean/Buttons/popupMenu.dart';
import 'package:flutter_app_newocean/Landing/Home_view.dart';
import 'package:flutter_app_newocean/Login/Login_View/Login_responsive.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:flutter_app_newocean/ocean_icon/ocean_icons.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _firestore = FirebaseFirestore.instance;

// ignore: must_be_immutable
class TabletLoginMenu extends StatefulWidget {
  TabletLoginMenu({this.userProfile});
  String userProfile;
  @override
  _TabletLoginMenuState createState() => _TabletLoginMenuState();
}

class _TabletLoginMenuState extends State<TabletLoginMenu> {
  getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginResponsive.registerNumber = (prefs.getString('user') ?? null);
  }

  String userProfile;

  notification() async {
    var db = await _firestore.collection('new users').get();
    var notify = db.docs;
    for (var title in notify) {
      print(title['First Name']);
      FocusedMenuItem item = FocusedMenuItem(
          title: Text(
            title['First Name'],
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            print(title['First Name']);
          },
          backgroundColor: Colors.grey[700]);
      notificationItem.add(item);
      if (notificationItem.length == 4) {
        break;
      }
    }
    notificationItem.add(FocusedMenuItem(
        title: Text(
          'See All',
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        onPressed: () {}));
  }

  List<FocusedMenuItem> notificationItem = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSession();
    print('hhhhhhhhhhhhhhhhhhhhhhhhhh');
    notification();

    //getImage();
  }

  GlobalKey notificationKey = GlobalKey();
  void onClickMenu(MenuItemProvider item) async {
    print('selected menu -> ${item.menuTitle}');
    // Provider.of<Routing>(context, listen: false)
    //     .updateRouting(widget: CoursesView());
    // Provider.of<UserProfiles>(context, listen: false)
    //     .updateUser(routing: Notification_onclick());
  }

  void popupMenuButton() {
    PopupMenu menu = PopupMenu(
      maxColumn: 1,
      incrementWidth: 100,
      backgroundColor: Colors.grey[700],
      lineColor: Colors.blue,
      shadow: false,
      onClickMenu: onClickMenu,
      // highlightColor: Colors.red,
      items: [
        MenuItem(
            title: 'See all Notification',
            textStyle: TextStyle(fontSize: 15, color: Colors.white)),
      ],
    );
    menu.show(widgetKey: notificationKey);
  }

  final valueController = Get.find<ValueListener>();

  String test;
  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    // session();
    return Stack(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(15.0),
              height: 100.0,
              color: Color(0xff0091D2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.menu,
                      ),
                      color: Colors.white,
                      iconSize: 25,
                      onPressed: () {
                        scaffoldKey.currentState.openDrawer();
                      }),
                  GestureDetector(
                    onTap: () {
                      // Provider.of<Routing>(context, listen: false)
                      //     .updateRouting(widget: Home());
                      // Provider.of<MenuBar>(context, listen: false)
                      //     .updateMenu(widget: NavbarRouting());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Ocean.oa,
                          size: 40.0,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "ocean academy",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream:
                              _firestore.collection('new users').snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text("Loading...");
                            } else {
                              final messages = snapshot.data.docs;
                              List<ProfilePictureDb> profile = [];

                              for (var message in messages) {
                                // var id = valueController.userNumber.value != null
                                //     ? MenuBar.stayUser
                                //     : LogIn.registerNumber;
                                if (message.id ==
                                    LoginResponsive.registerNumber) {
                                  final profileImage =
                                      message['Profile Picture'];

                                  final pictures = ProfilePictureDb(
                                    profilePicture: profileImage,
                                    // onpress: () {
                                    //   // setState(() {
                                    //   //   ContentWidget.isShow =
                                    //   //       !ContentWidget.isShow;
                                    //   //
                                    //   //   ContentWidget.isVisible = false;
                                    //   // });
                                    //   // Provider.of<Routing>(context,
                                    //   //         listen: false)
                                    //   //     .updateRouting(widget: CoursesView());
                                    //   //
                                    //   // Provider.of<UserProfiles>(context,
                                    //   //         listen: false)
                                    //   //     .updateUser(routing: User_Profile());
                                    // },
                                  );
                                  profile.add(pictures);
                                }
                              }
                              return MaterialButton(
                                child: Row(
                                  children: profile,
                                ),
                              );
                            }
                          },
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: FocusedMenuHolder(
                            openWithTap: true,
                            blurBackgroundColor: Colors.transparent,
                            animateMenuItems: false,
                            blurSize: 0,
                            animationDuration: 50,
                            arrowColor: Colors.grey[700],
                            menuWidth: 350,
                            onPressed: () {
                              locator<NavigationService>().navigateTo(
                                  "/UserNotification?id=${LoginResponsive.registerNumber}");
                            },
                            menuItemExtent: 55,
                            menuItems: notificationItem,
                            child: Icon(
                              Icons.notifications_none_outlined,
                              color: Color(0xFF0091D2),
                              size: 40.0,
                            ),
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
      ],
    );
    //   ],
    // );
  }
}

class TraingleClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(5, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(5, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

// ignore: must_be_immutable
class ProfilePictureDb extends StatefulWidget {
  String profilePicture;
  ProfilePictureDb({
    this.profilePicture,
  });
  @override
  _ProfilePictureDbState createState() => _ProfilePictureDbState();
}

class _ProfilePictureDbState extends State<ProfilePictureDb> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.all(15.0),
      minWidth: 10.0,
      hoverColor: Colors.white10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(600.0),
        ),
      ),
      onPressed: () {
        scaffoldKey.currentState.openEndDrawer();
      },
      child: widget.profilePicture != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.network(
                widget.profilePicture,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            )
          : Icon(
              FontAwesomeIcons.solidUserCircle,
              size: 50,
              color: Colors.white,
            ),
    );
  }
}
