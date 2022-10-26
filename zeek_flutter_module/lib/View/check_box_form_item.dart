import 'package:flutter/material.dart';
import '../Model/form_item_model.dart';

class CheckBoxResult {
  final bool isCheck;
  final String selectValue;

  CheckBoxResult(this.isCheck, this.selectValue);
}

/// 用于表单列表的checkbox视图
class CheckBoxFormItem extends StatefulWidget {
  final FormItemModel model;
  final void Function(CheckBoxResult value) onChange;

  const CheckBoxFormItem(
      {Key? key, required this.model, required this.onChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CheckBoxFormItemState();
  }
}

class _CheckBoxFormItemState extends State<CheckBoxFormItem> {
  String leftText = "";
  String rightText = "";
  String bottomText = "";

  /// 是否有说明文档
  bool hasDocument = false;
  bool isCheck = false;

  @override
  void initState() {
    super.initState();
    this.leftText = widget.model.title;
    this.rightText = widget.model.subTitle;
    this.bottomText = widget.model.hint;
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
                  Expanded(child: _leftContent(context)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: _rightContent(context),
                  )
                ],
              ),
            ),
            (this.isCheck && this.bottomText.length > 0)
                ? _bottomContent(context)
                : Container()
          ],
        ));
  }

  void _changeCheckState() {
    this.isCheck = !this.isCheck;
    setState(() {});
    widget.onChange(CheckBoxResult(this.isCheck, this.rightText));
  }

  Widget _leftContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
            value: this.isCheck,
            onChanged: (bool? value) {
              _changeCheckState();
            }),
        InkWell(
          child: Text(
            this.leftText,
            style: Theme.of(context).textTheme.headline6,
          ),
          onTap: _changeCheckState,
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
    return Text(
      this.rightText,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
          color: this.isCheck ? Color(0xFF000000) : Color(0xFF8C99A7)),
    );
  }

  Widget _bottomContent(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(50, 0, 15, 10),
        child: Text(
          this.bottomText,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.red),
        ));
  }
}
