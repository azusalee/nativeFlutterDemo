/// 与App交互的方法集合
class APPMethods {
  /// 获取本地化名字
  /// 带参数String，对应本地化的key
  /// 返回本地化文字String
  static const String getLocalizeName = 'getLocalizeName';

  /// 请求消息列表
  /// 带字典参数，page, page_size
  /// 返回数据数组
  static const String requestMessageList = 'requestMessageList';

}