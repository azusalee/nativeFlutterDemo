import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:zeek_flutter_module/Model/form_item_model.dart';
import '../Constant/APPMethods.dart';
import '../Manager/main_manager.dart';
import '../Utils/ViewUtils.dart';
import '../Constant/APPRoutes.dart';
import '../View/check_box_form_item.dart';
import '../View/input_form_item.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _nativeMessage = '';
  String _title = '';

  @override
  void initState() {
    super.initState();

    //sendUpdateTitle();
  }

  Future<String> sendUpdateTitle() async {
    String reply = await MainManager.mainManager.appChannel.methodChannel
        .invokeMethod(APPMethods.getLocalizeName, 'home');
    _title = reply;
    setState(() {});
    return reply;
  }

  Future<String> sendMessage() async {
    Object? reply = await MainManager.mainManager.appChannel.messageChannel
        .send('发送给Native端的数据');
    String replyContent = reply.toString();
    print('reply: $replyContent');
    return replyContent;
  }

  Future<String> sendMethod() async {
    String reply = await MainManager.mainManager.appChannel.methodChannel
        .invokeMethod("method1");
    print('method: $reply');
    return reply;
  }

  /// 点击
  void _incrementCounter() async {
    _nativeMessage = await sendMessage();
    setState(() {
      _counter++;
    });
    MainManager.mainManager.appChannel.pushNativePage(APPRoutes.home, {}, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ViewUtils.createBackIconButton(context),
        title: Text(_title),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.green,
        child: SingleChildScrollView(
            child: IntrinsicWidth(
          child: Column(
            children: [
              CheckBoxFormItem(
                  model: FormItemModel(
                      title: "标题标题标题", subTitle: "内容值", hint: "提示内容"),
                  onChange: (result) {

                  }
              ),
              InputFormItem(model: FormItemModel(
                  title: "标题标题标题", subTitle: "内容值", hint: "提示内容"
              ), onChange: (result) {

              })
            ],
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
