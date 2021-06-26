import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(
    String routeName,
  ) {
    return navigatorKey.currentState.pushNamed(
      routeName,
    );
  }

  // ignore: missing_return
  bool goBack() {
    navigatorKey.currentState.canPop();
  }
}

///void goBack() {
//     navigatorKey.currentState.pop();
//   }
