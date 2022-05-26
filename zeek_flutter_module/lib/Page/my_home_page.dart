import 'package:flutter/material.dart';
import '../Constant/APPMethods.dart';
import '../Manager/main_manager.dart';
import '../Utils/ViewUtils.dart';

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
    String reply = await MainManager.mainManager.appChannel.methodChannel.invokeMethod(APPMethods.getLocalizeName, 'home');
    _title = reply;
    setState(() {

    });
    return reply;
  }

  Future<String> sendMessage() async {
    Object? reply = await MainManager.mainManager.appChannel.messageChannel.send('发送给Native端的数据');
    String replyContent = reply.toString();
    print('reply: $replyContent');
    return replyContent;
  }

  Future<String> sendMethod() async {
    String reply = await MainManager.mainManager.appChannel.methodChannel.invokeMethod("method1");
    print('method: $reply');
    return reply;
  }
  
  /// 点击
  void _incrementCounter() async {
    _nativeMessage = await sendMessage();
    setState(() {
      _counter++;
    });
    Navigator.of(context).pushNamed("/message");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: ViewUtils.createBackIconButton(context),
        title: Text(_title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter\n$_nativeMessage',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}