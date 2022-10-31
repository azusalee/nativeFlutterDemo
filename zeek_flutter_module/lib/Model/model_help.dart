

/// 表单模型的帮助信息
class ModelHelp {

  /// 原始json数据
  final Map<String, dynamic> rawJson;
  /// 帮助的url
  String? url;
  /// 帮助的内容
  String? content;
  ModelHelp({
    required this.rawJson}) {
    this.url = rawJson["url"];
    this.content = rawJson["content"];

  }
}