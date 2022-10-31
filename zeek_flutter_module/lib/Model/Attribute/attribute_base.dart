/// 属性基类
class AttributeBase {
  /// 属性名
  final String name;
  /// 原始json数据
  final Map<String, dynamic> rawJson;
  /// 属性类型
  String? type;
  /// 是否必填
  bool required = false;

  AttributeBase({
    required this.name,
    required this.rawJson}) {
    this.type = rawJson["type"];
    this.required = rawJson["required"];
  }
}