import 'package:flutter/material.dart';
import '../Page/my_home_page.dart';
import '../Page/tasker_home_page.dart';
import '../Page/message_page.dart';

class Routes {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // 路由设定
  static Map<String, WidgetBuilder> routes = {
    "/home": (context) => MyHomePage(),
    "/tasker_home": (context) => const TaskerHomePreview(),
    "/message": (context) => MessagePage()
  };
}