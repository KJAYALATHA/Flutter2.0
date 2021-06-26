import 'package:flutter/material.dart';

class MenuItem {
  MenuItem({this.title, this.icon});
  String title;
  IconData icon;
}

List<MenuItem> menuItemList = [
  MenuItem(title: 'Home', icon: Icons.home),
  MenuItem(title: 'About Us', icon: Icons.info),
  MenuItem(title: 'Service', icon: Icons.miscellaneous_services_rounded),
  MenuItem(title: 'Course', icon: Icons.menu_book),
  MenuItem(title: 'Contact Us', icon: Icons.contact_phone),
];
