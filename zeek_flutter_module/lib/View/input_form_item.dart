import 'package:flutter/material.dart';
import '../Model/form_item_model.dart';

class InputResult {
  final String inputText;

  InputResult(this.inputText);
}

/// 用于表单列表的输入视图
class InputFormItem extends StatefulWidget {
  final FormItemModel model;
  final void Function(InputResult value) onChange;

  const InputFormItem({Key? key, required this.model, required this.onChange}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InputFormItemState();
  }
}

class _InputFormItemState extends State<InputFormItem> {
  @override
  void initState() {
    super.initState();
    //sendUpdateTitle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.white,
    );
  }
}