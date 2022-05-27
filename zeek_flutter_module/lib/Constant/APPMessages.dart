
/// App发过来的信息集合
/// 所有消息都按以下的格式发送
/// {
/// "message": "changeRootRoute",
/// "data": String
/// }
///
class APPMessages {

}

/// 由Flutter传过去原生的信息
class FlutterMessages {
  /// 原生与flutter的通道建立完成的消息
  static const String channelSetup = 'channelSetup';
}