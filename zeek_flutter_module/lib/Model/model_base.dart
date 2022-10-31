import 'Attribute/attribute_factory.dart';
import 'Attribute/attribute_base.dart';
import 'model_info.dart';
import 'model_view.dart';

/// 通用表单模型类
class ModelBase {
  /// 原始json数据
  final Map<String, dynamic> rawJson;
  /// 模型信息
  ModelInfo? info;
  /// 模型视图配置
  ModelViewOption? view;
  /// 模型属性
  Map<String, AttributeBase> attributes = {};

  ModelBase({
    required this.rawJson}) {
    if (rawJson["info"] is Map<String, dynamic>) {
      this.info = ModelInfo(rawJson: rawJson["info"]);
    }
    if (rawJson["view"] is Map<String, dynamic>) {
      this.view = ModelViewOption(rawJson: rawJson["view"]);
    }
    Map<String, dynamic> attributeDicts = rawJson["attributes"];
    attributeDicts.forEach((key, value) {
      AttributeBase? attribute = AttributeFactory.createAttribute(key, value);
      if (attribute != null) {
        this.attributes[key] = attribute!;
      }
    });
  }
}



