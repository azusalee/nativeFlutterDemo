import '../Utils/localize_utils.dart';

/*
  参考数据
 section_name可能不是字典，而是一个字符串
  {
    "section_icon": "md-person"
    "section_name": {
      "en": "Address",
      "zh-HK": "地址"
    }
  },
 */

/// 某个属性编辑的配置项
class EditAttributeViewOption {
  /// 原始json数据
  final Map<String, dynamic> rawJson;

  /// 属性的名字(多语言)
  Map<String, String>? _sectionName;
  String? _sectionNameString;

  /// 属性的图标
  String? sectionIcon;

  ///整組的 Attribute 設置傳入
  /// section_name可能不是字典，而是一个字符串
  ///{
  ///  "section_icon": "md-person"
  ///   "section_name": {
  ///   "en": "Address",
  ///   "zh-HK": "地址"
  ///   }
  ///   },
  ///
  EditAttributeViewOption({
    required this.rawJson}) {
    if (rawJson["section_name"] is Map<String, String>) {
      this._sectionName = rawJson["section_name"];
    } else {
      this._sectionNameString = rawJson["section_name"];
    }
    this.sectionIcon = rawJson["section_icon"];
  }

  /// 获取本地化名字
  String? localizeName({String? languageCode}) {
    if (this._sectionName == null) {
      return this._sectionNameString;
    }
    return LocalizeUtils.localizeString(this._sectionName!, languageCode);
  }
}