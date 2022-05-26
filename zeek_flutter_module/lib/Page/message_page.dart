import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Utils/ViewUtils.dart';
import '../Manager/main_manager.dart';
import '../Constant/APPMethods.dart';
import '../Model/message_model.dart';
import 'dart:convert';

class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  /// 用于监听列表滚动
  ScrollController _scrollController = ScrollController();

  String _title = '';
  int _currentPage = 1;
  final int _pageSize = 20;

  /// 是否正在加载
  bool _isLoadingNew = false;
  bool _isLoadingMore = false;

  List<MessageModel> dataArray = [];

  @override
  void initState() {
    super.initState();
    _updateTitle();
    _loadNewData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreData();
      }
    });
  }

  Future<String> _updateTitle() async {
    String reply = await MainManager.mainManager.appChannel.methodChannel
        .invokeMethod(APPMethods.getLocalizeName, "message");
    setState(() {
      _title = reply;
    });
    return reply;
  }

  /// 下拉刷新
  Future<Null> _loadNewData() async {
    _isLoadingNew = true;
    try {
      String reply = await MainManager.mainManager.appChannel.methodChannel
          .invokeMethod(APPMethods.requestMessageList,
              {"page": 1, "page_size": _pageSize});
      _currentPage = 2;
      dataArray.clear();
      List mapList = json.decode(reply);
      mapList.forEach((element) {
        dataArray.add(MessageModel.fromJson(element));
      });
    } on PlatformException catch (e) {
      // 错误
    }

    setState(() {});
    _isLoadingNew = false;
    return null;
  }

  /// 上拉加载
  Future<Null> _loadMoreData() async {
    if (_isLoadingNew || _isLoadingMore) {
      return null;
    }
    _isLoadingMore = true;
    try {
      String reply = await MainManager.mainManager.appChannel.methodChannel
          .invokeMethod(APPMethods.requestMessageList,
              {"page": _currentPage, "page_size": _pageSize});
      _currentPage += 1;
      List mapList = json.decode(reply);
      mapList.forEach((element) {
        dataArray.add(MessageModel.fromJson(element));
      });
    } on PlatformException catch (e) {
      // 错误
    }

    setState(() {});
    _isLoadingMore = false;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: ViewUtils.createBackIconButton(context),
          title: Text(_title),
        ),
        body: RefreshIndicator(
            onRefresh: _loadNewData,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: dataArray.length,
              itemBuilder: _listItemBuilder,
            )));
  }
  
  void _onTap(int index) {
    // item 点击回调
    print('$index 点击');
    MainManager.mainManager.appChannel.pushFlutterPage("/home");
  }

  /// 列表的item样式
  Widget _listItemBuilder(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Theme.of(context).cardColor,
          child: InkWell(
            child: Container(
              padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dataArray[index].title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          dataArray[index].time,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            onTap: () => {
              _onTap(index)
            },
          ),
        ),
        Divider(
          color: Theme.of(context).scaffoldBackgroundColor,
          height: 10,
          thickness: 10,
        )
      ],
    );
  }
}
