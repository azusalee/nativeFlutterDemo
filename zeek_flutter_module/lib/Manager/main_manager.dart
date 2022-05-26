import '../Handler/app_channel_handler.dart';

/// 主管理器，用于持有各种需要全局获取的对象
class MainManager {
  // 主管理器
  static MainManager mainManager = MainManager(
      appChannel: AppChannelHandler()
  );

  /// 与app交互的通道处理类
  final AppChannelHandler appChannel;

  MainManager({required this.appChannel});
}