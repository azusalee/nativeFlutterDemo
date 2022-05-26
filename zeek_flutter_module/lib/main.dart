import 'package:flutter/material.dart';
import 'Page/my_home_page.dart';
import 'Manager/main_manager.dart';
import 'Constant/Routes.dart';
import 'Constant/APPMessages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // 告诉原生已经建立好通信
    MainManager.mainManager.appChannel.messageChannel.send(FlutterMessages.channelSetup);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: Routes.routes,
      navigatorKey: Routes.navigatorKey,
    );
  }
}

