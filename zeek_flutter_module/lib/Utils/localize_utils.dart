import '../Manager/main_manager.dart';

/// 本地化处理的工具类
class LocalizeUtils {
  /// 获取本地化文字
  static String? localizeString(Map<String, String> stringDict, String? languageCode) {
    if (languageCode == null) {
      // 全局语言
      languageCode = MainManager.mainManager.languageCode;
    }
    // 转换code, zh_HK转成zh-HK，使其对上
    languageCode = languageCode.replaceAll("_", "-");
    // 指定语言
    if (stringDict[languageCode] != null) {
      return stringDict[languageCode];
    }
    // 英语
    if (stringDict["en"] != null) {
      return stringDict["en"];
    }
    // 第一种语言
    return stringDict.values.first;
  }
}