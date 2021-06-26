import 'package:flutter/material.dart';

class SliderContent extends ChangeNotifier {
  String title = "", description = "";

  void updateValue(String title, String description) {
    this.title = title;
    this.description = description;
    notifyListeners();
  }
}

class UpcomingModel extends ChangeNotifier {
  int flag = 0;

  void updateFlags(int flag) {
    this.flag = flag;
    notifyListeners();
  }
}

class ClassMenu extends ChangeNotifier {
  bool isLogin = false;

  void updateMenu(bool isLogin) {
    this.isLogin = isLogin;
    notifyListeners();
  }
}
