import 'edit_attribute_view_option.dart';

/* 参考数据
  "view":{
      "list":{
         "sort":"id:ASC", # sortField(), sortDirection()
         "pageSize":"50", # pageSize()
         "fields":[  # attributeNames() array of string
            "name",
            "code",
            "email",
            "launch_time"
         ],
         "search":true, # supportTextSearch()
         "filter":true, # supportFilter()
         "bulkAction":[ # supportBulkDelete(), supportBulkMove()(TreeStyle)
            "delete"
         ]
      },
      "edit": {
        "attributes":{
            "email": {
                "section_name": {
                    "en": "Login",
                    "zh-HK": "登入"
                }
            },
            "address": {
                "section_name": {
                    "en": "Address",
                    "zh-HK": "地址"
                }
            }
        }
      }
   }
 */

/// 表单模型的视图配置, 用于控制视图上的一些显示(如多语言文字之类的)
class ModelViewOption {
  /// 原始json数据
  final Map<String, dynamic> rawJson;

  Map<String, EditAttributeViewOption> editAttributeOptions = {};

  ModelViewOption({
    required this.rawJson}) {
    // 编辑配置
    Map<String, dynamic>? edit = rawJson["edit"];
    if (edit != null) {
      Map<String, dynamic>? attributes = edit["attributes"];
      if (attributes != null) {
        attributes.forEach((key, value) {
          this.editAttributeOptions[key] = EditAttributeViewOption(rawJson: value);
        });
      }
    }
    // 列表(待实现)
  }

  String? attributeName(String name) {
    return this.editAttributeOptions[name]?.localizeName();
  }

  String? attributeIcon(String name) {
    return this.editAttributeOptions[name]?.sectionIcon;
  }
}