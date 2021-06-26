import 'package:flutter/material.dart';
import 'package:flutter_app_newocean/Login_Menubar/responsive_login_menu.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:get/get.dart';

void main() {
  Get.put(ValueListener());
  runApp(GetMaterialApp(
    title: 'Thamizh testing page',
    home: Scaffold(
      body: ResponsiveLoginMenu(),
    ),
  ));
}

// class CustomMenu extends StatefulWidget {
//   const CustomMenu({Key key, this.title = 'testing', this.rootMenu = false})
//       : super(key: key);
//
//   final String title;
//   final bool rootMenu;
//
//   @override
//   _CustomMenuState createState() => _CustomMenuState();
// }
//
// class _CustomMenuState extends State<CustomMenu> {
//   WhyFarther _selection = WhyFarther.smarter;
//
//   @override
//   Widget build(BuildContext context) {
// // This menu button widget updates a _selection field (of type WhyFarther,
// // not shown here).
//
//     return Padding(
//       padding: const EdgeInsets.all(2.0),
//       child: GestureDetector(
//           onTap: () {
//             // This offset should depend on the largest text and this is tricky when
//             // the menu items are changed
//             Offset offset = widget.rootMenu ? Offset.zero : Offset(300, 0);
//
//             final RenderBox button = context.findRenderObject();
//             final RenderBox overlay =
//                 Overlay.of(context).context.findRenderObject();
//             final RelativeRect position = RelativeRect.fromRect(
//               Rect.fromPoints(
//                 button.localToGlobal(Offset.zero, ancestor: overlay),
//                 button.localToGlobal(button.size.bottomRight(Offset.zero),
//                     ancestor: overlay),
//               ),
//               offset & overlay.size,
//             );
//             showMenu(
//                 context: context,
//                 position: position,
//                 items: <PopupMenuEntry<WhyFarther>>[
//                   const PopupMenuItem<WhyFarther>(
//                     value: WhyFarther.harder,
//                     child: Text('Working a lot harder'),
//                   ),
//                   const PopupMenuItem<WhyFarther>(
//                     value: WhyFarther.smarter,
//                     child: Text('Being a lot smarter'),
//                   ),
//                   const PopupMenuItem<WhyFarther>(
//                     value: WhyFarther.selfStarter,
//                     child: CustomMenu(title: 'Sub Menu long'),
//                   ),
//                   const PopupMenuItem<WhyFarther>(
//                     value: WhyFarther.tradingCharter,
//                     child: Text('Placed in charge of trading charter'),
//                   ),
//                 ]).then((selectedValue) {
//               // do something with the value
//               if (Navigator.canPop(context)) Navigator.pop(context);
//             });
//           },
//           child: Material(
//             textStyle: Theme.of(context).textTheme.subtitle1,
//             elevation: widget.rootMenu ? 2.0 : 0.0,
//             child: Padding(
//               padding:
//                   widget.rootMenu ? EdgeInsets.all(8.0) : EdgeInsets.all(0.0),
//               child: Row(
//                 children: <Widget>[
//                   Text(widget.title),
//                   if (!widget.rootMenu) Spacer(),
//                   if (!widget.rootMenu) Icon(Icons.arrow_right),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }

//============================================================

//
// class CourseDropdown extends StatefulWidget {
//   @override
//   _CourseDropdownState createState() => _CourseDropdownState();
// }
//
// class _CourseDropdownState extends State<CourseDropdown> {
//   List<String> courseList = [
//     'Online',
//     'Offline',
//   ];
//   GlobalKey dropdownKey;
//   bool isDropdown = false;
//   double height, width, xPosition, yPosition;
//   OverlayEntry floatingDropdown;
//
//   findDropdownData() {
//     RenderBox renderBox = dropdownKey.currentContext.findRenderObject();
//     height = renderBox.size.height;
//     width = renderBox.size.width;
//     Offset offset = renderBox.localToGlobal(Offset.zero);
//     xPosition = offset.dx;
//     yPosition = offset.dy;
//   }
//
//   OverlayEntry createFloatingDropdown() {
//     return OverlayEntry(builder: (context) {
//       return Positioned(
//           left: xPosition,
//           width: width,
//           top: height + xPosition + 5,
//           height: courseList.length * height,
//           child: Container(
//             height: 100,
//             width: 100,
//             color: Colors.blue,
//           ));
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         MouseRegion(
//           cursor: SystemMouseCursors.click,
//           child: GestureDetector(
//             child: Text(
//               'Course',
//               style: TextStyle(
//                   color: Color(0xFF155575),
//                   fontSize: 20.0,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "Gilroy"),
//             ),
//             key: dropdownKey,
//             onTap: () {
//               isDropdown = !isDropdown;
//               if (isDropdown) {
//                 findDropdownData();
//                 floatingDropdown = createFloatingDropdown();
//                 Overlay.of(context).insert(floatingDropdown);
//               } else {
//                 floatingDropdown.remove();
//               }
//             },
//           ),
//         ),
//         PopupMenuButton(itemBuilder: (context) {
//           return <PopupMenuEntry<int>>[
//             PopupMenuItem(
//               child: Text('Online'),
//               value: 1,
//             )
//           ];
//         }),
//       ],
//     );
//   }
// }

//
// class CustomDropDown extends StatefulWidget {
//   final String text;
//
//   const CustomDropDown({Key key, this.text = 'DropDown'}) : super(key: key);
//   @override
//   _CustomDropDownState createState() => _CustomDropDownState();
// }
//
// class _CustomDropDownState extends State<CustomDropDown> {
//   GlobalKey actionKey;
//   bool isDropdown = false;
//   double height, width, xPosition, yPosition;
//   OverlayEntry floatingDropdown;
//   List dropdownItems = [1, 2, 3, 4];
//   double triangleHeight = 40;
//   double gap = 3;
//
//   findDropDownData() {
//     RenderBox renderBox = actionKey.currentContext.findRenderObject();
//     height = renderBox.size.height;
//     width = renderBox.size.width;
//     Offset offset = renderBox.localToGlobal(Offset.zero);
//     xPosition = offset.dx;
//     yPosition = offset.dy;
//     print(height);
//     print(width);
//     print(xPosition);
//     print(yPosition);
//   }
//
//   OverlayEntry _createFloatingDropdown() {
//     return OverlayEntry(builder: (context) {
//       return Positioned(
//         left: xPosition,
//         width: width,
//         top: height + yPosition + gap,
//         height: dropdownItems.length * height + triangleHeight,
//         child: Container(
//           height: 100,
//           width: 100,
//           color: Colors.pink,
//         ),
//       );
//     });
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     actionKey = GlobalKey();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       key: actionKey,
//       onTap: () {
//         isDropdown = !isDropdown;
//         if (isDropdown) {
//           findDropDownData();
//           floatingDropdown = _createFloatingDropdown();
//           Overlay.of(context).insert(floatingDropdown);
//         } else {
//           floatingDropdown.remove();
//         }
//
//         print(isDropdown);
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         color: Colors.red.shade300,
//         height: 50,
//         width: 300,
//         child: Row(
//           children: [
//             Text(
//               widget.text,
//               style: TextStyle(color: Colors.white),
//             ),
//             Spacer(),
//             Icon(
//               Icons.arrow_drop_down_sharp,
//               color: Colors.white,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
