import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Constant/APPMethods.dart';
import 'dart:convert';
import '../Constant/APPMessages.dart';
import '../Constant/Routes.dart';

class AppChannelHandler {
  BasicMessageChannel messageChannel = const BasicMessageChannel('/app/message', StandardMessageCodec());
  MethodChannel methodChannel = const MethodChannel('/app/method');
  EventChannel eventChannel = const EventChannel('/app/event');

  AppChannelHandler() {
    this.setup();
  }

  void setup() {
    // message事件
    messageChannel.setMessageHandler((message) async {
      print('message: $message');
      Map dict = json.decode(message);
      String messageName = dict["message"];
      print('信息名 $messageName');
      if (messageName == APPMessages.changeRootRoute) {
        String data = dict["data"];
        // 更换根页面
        print('更换页面 $data');
        // 不要过场动画
        var pageBuilder = Routes.routes[data];
        if (pageBuilder != null) {
          PageRouteBuilder route = PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 0),
              pageBuilder: (BuildContext context,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation)
              { return pageBuilder!(context); });
          Routes.navigatorKey.currentState?.pushAndRemoveUntil(route, (route) => false);
        }
        //Routes.navigatorKey.currentState?.pushNamedAndRemoveUntil(data, (route) => false);
      }
      return '收到Natvie数据';
    });
    //Navigator.of(context);
    // event事件
    eventChannel.receiveBroadcastStream().listen((event) {

    });
  }

  /// 让原生跳转指定页面
  void pushNativePage(String nativeRoute) {
    this.methodChannel.invokeMethod(APPMethods.pushNativePage, nativeRoute);
  }

  /// 让原生跳指定flutter页面
  void pushFlutterPage(String flutterRoute) {
      this.methodChannel.invokeMethod(APPMethods.pushFlutterPage, flutterRoute);
  }
}