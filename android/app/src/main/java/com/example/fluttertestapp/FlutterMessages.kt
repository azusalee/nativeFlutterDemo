package com.example.fluttertestapp

/// 发送给flutter的消息名集
object FlutterMessages {
    /*
     所有消息都按以下的格式发送
 {
 "message": "changeRootRoute",
 "data": String
 }
     */

    /// 更换flutter的根页面
    /// 带参数String，更换的页面的Route Key
    final var changeRootRoute = "changeRootRoute"
}