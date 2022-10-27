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

  const InputFormItem({Key? key, required this.model, required this.onChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _InputFormItemState();
  }
}

class _InputFormItemState extends State<InputFormItem> {
  String leftText = "";
  String rightText = "";

  /// 是否有说明文档
  bool hasDocument = false;

  TextEditingController inputController = TextEditingController();


  @override
  void initState() {
    super.initState();
    this.leftText = widget.model.title;
    //sendUpdateTitle();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              //color: Colors.blue,
              //width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: _leftContent(context),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: _rightContent(context),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget _leftContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          this.leftText,
          style: Theme.of(context).textTheme.headline6,
        ),
        // 展示说明的图标(不一定有)
        this.hasDocument
            ? InkWell(
                child: Icon(
                  IconData(0xe6eb, fontFamily: 'iconfont'),
                  size: 20,
                  color: Colors.white,
                ),
                onTap: () {
                  // 点击展示说明
                },
              )
            : Container()
      ],
    );
  }

  Widget _rightContent(BuildContext context) {
    return TextField(
      controller: this.inputController,
      textAlign: TextAlign.right,
      decoration:
          InputDecoration(hintText: "\$0", border: InputBorder.none),
      onChanged: (textValue) {
        if (textValue.length > 0) {
          if (textValue.startsWith("\$") == false) {
              this.inputController.text = "\$"+textValue;
              setState(() {

              });
          }
        }
      },
    );
  }
}
