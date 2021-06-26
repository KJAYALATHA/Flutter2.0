import 'package:flutter/material.dart';

import 'package:flutter_app_newocean/Login_Menubar/responsive_login_menu.dart';

import 'package:flutter_app_newocean/Menu/ResponsiveMenu.dart';
import 'package:flutter_app_newocean/Webinar/webinar_menubar/responsive_webinar_menubar.dart';
import 'package:flutter_app_newocean/getx_controller.dart';
import 'package:flutter_app_newocean/layout_builder.dart';
import 'package:flutter_app_newocean/route/Provider/provider_routing.dart';
import 'package:flutter_app_newocean/route/dynamic_routing.dart';
import 'package:flutter_app_newocean/route/navigation_locator.dart';
import 'package:flutter_app_newocean/route/navigation_service.dart';
import 'package:flutter_app_newocean/route/routeNames.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  // GestureBinding.instance.resamplingEnabled = true;
  setupLocator();
  setPathUrlStrategy();
  Get.put(ValueListener());
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static String session;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final valueController = Get.find<ValueListener>();

  String route;

  sessionCheck() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    MyApp.session = (prefs.getString('user') ?? null);
    route = MyApp.session != null

        ///'/ClassRoom?userNumber=$session&typeOfCourse=${valueController.courseType.value}'
        ? '/ClassRoom?userNumber=${MyApp.session}&typeOfCourse=${valueController.courseType.value}'
        : HomeRoute;
    print("routeChecking in mainpage${route}");
    print("routeChecking in mainpage session${MyApp.session}");
    MyApp.session != null
        ? valueController.navebars.value = 'Login'
        : valueController.navebars.value = 'Home';
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sessionCheck();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SliderContent()),
          ChangeNotifierProvider(create: (context) => UpcomingModel()),
        ],
        child: GetMaterialApp(
          title: 'Ocean Academy',
          builder: (context, child) => MainLayout(
            menubar: Obx(() {
              if (valueController.navebars.value == 'Login') {
                return ResponsiveLoginMenu();
              } else if (valueController.navebars.value == 'Webinar') {
                return ResponsiveWbinarMenubar();
              } else {
                return ResponsiveMenu();
              }
            }),
            child: child,
          ),
          showPerformanceOverlay: false,
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: generateRoute,
          initialRoute: route,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ));
  }
}
