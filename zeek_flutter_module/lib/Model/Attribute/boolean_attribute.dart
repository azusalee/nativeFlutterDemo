import 'attribute_base.dart';
import '../../Utils/localize_utils.dart';

/// 布尔型属性
class BooleanAttribute extends AttributeBase {
  /// 数据格式
  /// - 支持多種二選一的數據。
  ///  *  - boolean 類型 Data 為： true, false, null
  ///  *  - integer 類型 Data 為： 1, 0, null
  ///  *  - yes_no  類型 Data 為： 'Yes', 'No', null
  ///  *  - on_off  類型 Data 為： 'On', 'Off', null
  String dataType = "boolean";

  /// 本地化文字
  Map<String, dynamic>? _localized;

  /// 接口值与本地值转换的字典
  Map<String, dynamic>? _valueDefines;

  Map<String, dynamic> _defaultYesNoLocalize = {
    'T': {
      'en': 'Yes',
      'zh-HK': '是'
    },
    'F': {
      'en': 'No',
      'zh-HK': '否'
    }
  };

  Map<String, dynamic> _defaultOnOffLocalize = {
    'T': {
      'en': 'On',
      'zh-HK': '開'
    },
    'F': {
      'en': 'Off',
      'zh-HK': '關'
    }
  };

  /// 从字典创建对象
  BooleanAttribute({
    required String name,
    required Map<String, dynamic> rawJson})
      : super(name: name, rawJson: rawJson) {

      if (rawJson["dataType"] != null) {
        this.dataType = rawJson["dataType"];
      }
      switch(this.dataType) {
        case 'integer':
          this._valueDefines = {
            'T': 1,
            'F': 0,
            'U': null
          };
          break;
        case 'yes_no':
          this._valueDefines = {
            'T': 'yes', // 存在DB的值，統一用小寫英文字母
            'F': 'no',
            'U': null
          };
          break;
        case 'on_off':
          this._valueDefines = {
            'T': 'on', // 存在DB的值，統一用小寫英文字母
            'F': 'off',
            'U': null
          };
          break;
        default:
          this._valueDefines = {
            'T': true,
            'F': false,
            'U': null
          };
          break;
      }

      Map<String, dynamic>? localize = rawJson["localized"];
      if (localize != null) {
        if (localize["_built_in_type"] != null) {
          String built_in_type = localize["_built_in_type"];
          switch(built_in_type) {
            case "OnOff":
              this._localized = this._defaultOnOffLocalize;
              break;
            case "YesNo":
              this._localized = this._defaultYesNoLocalize;
              break;
          }
        } else {
          this._localized = localize;
        }
      }
  }

  /// 获取本地化文字
  String? localizedString(String enumType, String? languageCode) {
    if (this._localized == null) {
      return null;
    }
    Map<String, String>? enumLocalize = this._localized?[enumType];
    if (enumLocalize == null) {
      return null;
    }
    return LocalizeUtils.localizeString(enumLocalize, languageCode);
  }

  /// bool转字符串key
  String _label(bool? isOn) {
    if (isOn == true) {
      return 'T';
    } else if (isOn == false) {
      return 'F';
    } else {
      return 'U';
    }
  }

  /// 字符串key转bool
  bool? _boolValue(String label) {
    if (label == 'T') {
      return true;
    } else if (label == 'F') {
      return false;
    }
    return null;
  }

  /// 根据dataType获取数据值(给回接口格式的值)
  dynamic returnValue(bool? isOn) {
    return this._valueDefines?[_label(isOn)];
  }

  /// 从数据值拿回布尔值
  bool? boolValue(dynamic returnValue) {
    String label = "U";
    this._valueDefines?.forEach((key, value) {
      if (value == returnValue) {
        label = key;
        return;
      }
    });
    return _boolValue(label);
  }
}