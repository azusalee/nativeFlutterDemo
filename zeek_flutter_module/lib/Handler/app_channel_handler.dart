import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
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

      return '收到Natvie数据';
    });
    //Navigator.of(context);
    // event事件
    eventChannel.receiveBroadcastStream().listen((event) {

    });
  }

  /// 告诉原生通道已经建立
  void sendChannelIsSetup() {
    this.messageChannel.send(FlutterMessages.channelSetup);
  }

  /// 让原生跳转指定页面
  void pushNativePage(String nativeRoute, Map<String, dynamic>? arguments, bool isAnimated) {
    Map<String, dynamic> params = {
      "isAnimated": isAnimated,
      "isPresent": false
    };
    if (arguments != null) {
      params.addAll(arguments!);
    }

    BoostNavigator.instance.push(
        nativeRoute,
        withContainer: true,
        arguments: arguments,
        opaque: true
    );
  }

}