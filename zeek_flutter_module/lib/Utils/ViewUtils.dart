import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 创建通用视图的工具类
class ViewUtils {

  /// 创建返回按钮
  static IconButton createBackIconButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => {
        // 返回按钮点击
        if (Navigator.of(context).canPop()) {
          Navigator.of(context).pop()
        } else {
          SystemNavigator.pop(animated: true)
        }
      },
    );
  }
}