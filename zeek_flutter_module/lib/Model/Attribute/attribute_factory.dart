import 'attribute_base.dart';
import 'boolean_attribute.dart';

/// 属性对象生成的工厂类
class AttributeFactory {

  /// 生成属性对象
  static AttributeBase? createAttribute(String name, Map<String, dynamic> rawJson) {
    String type = rawJson["type"];
    switch (type) {
      // 布尔型
      case "boolean":
        return BooleanAttribute(name: name, rawJson: rawJson);
    }

    // 格式不符合，生成不了
    return null;
  }
}