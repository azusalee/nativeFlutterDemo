import 'model_help.dart';

/*
 * "info": {
 *      "name": "env-zeek-market",
 *      "dbKey": "ENV_ZEEK",
 *      "primaryKey": "code",
 *      "primaryLabel": "name(code)", // 支持 組合 字段來顯示
 *      "action": {
 *          "create": true, // default true
 *          "update": true, // default true
 *          "delete": true, // default true
 *          "import": false, // default false
 *          "export": false, // default false
 *          "copy": false, // default false
 *          "publish": true    // ~same as update~
 *          "unpublish": true    // ~same as update~
 *      }
 *  },
 */

class ModelInfo {
  /// 原始json数据
  final Map<String, dynamic> rawJson;

  /// 模型名(相当于模型的唯一标识)
  String? name;
  /// 模型显示的名字
  String? displayName;
  /// 模型描述(用于显示)
  String? description;
  /// 主键
  String primaryKey = "id";
  String? primaryLabel;

  Map<String, bool> action = {
    "create": true,
    "update": true,
    "delete": true,
    "copy": false,
    "import": false,
    "export": false,
  };
  /// 帮助信息
  ModelHelp? help;

  ModelInfo({
    required this.rawJson}) {
    this.name = rawJson["name"];
    this.displayName = rawJson["displayName"];
    this.description = rawJson["description"];
    this.primaryKey = (rawJson["primaryKey"] != null)?rawJson["primaryKey"]:"id";
    this.primaryLabel = rawJson["primaryLabel"];
    if (rawJson["help"] is Map<String, dynamic>) {
      this.help = ModelHelp(rawJson: rawJson["help"]);
    }
    Map<String, bool>? actionDict = rawJson["action"];
    actionDict?.forEach((key, value) {
      this.action[key] = value;
    });
    if (this.action["publish"] == null) {
      this.action["publish"] = this.action["update"]!;
    }
    if (this.action["unpublish"] == null) {
      this.action["unpublish"] = this.action["update"]!;
    }
  }
}