import 'package:flutter/material.dart';

class TaskerHomePreview extends StatelessWidget {
  const TaskerHomePreview({Key? key}) : super(key: key);

  Column _buildButtonColumn(BuildContext context, IconData icon, String label, {String iconText = '', Color? iconTextColor}) {
    final color = Colors.white;
    final iconSize = 30.0;
    final fontSize = 15.0;
    iconTextColor ??= Colors.white;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      //列布局
      children: <Widget>[
        Stack(
          alignment: const Alignment(0.0, 0.2),
          children: [
            Icon(
              icon,
              size: iconSize,
              color: Colors.white,
            ),
            Text(
              iconText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
                color: iconTextColor,
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w200,
              color: color,
            ),
          ),
        )
      ],
    );
  }

  Column _buildSecondaryButtonColumn(BuildContext context, IconData? icon, String label, {String iconText = '', Color? iconTextColor}) {
    final color = Colors.black26;
    final iconSize = 25.0;
    final fontSize = 12.0;
    iconTextColor ??= color;

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      //列布局
      children: <Widget>[
        Stack(
          children: [
            Icon(
              icon,
              size: iconSize,
              color: Colors.black26,
            ),
            Text(
              iconText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: iconSize-10,
                fontWeight: FontWeight.w400,
                color: iconTextColor,
              ),
            )
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 3,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w200,
              color: color,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(0.0),
      child:
      Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    color: Colors.black,
                    height: 44,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          IconData(0xe7b8, fontFamily: 'iconfont'),
                          size: 20,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Text(
                            'Home',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        Icon(
                          IconData(0xe629, fontFamily: 'iconfont'),
                          size: 20,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.black,
                    height: 100,
                    child: Row (
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 1,
                          child: _buildButtonColumn(context, IconData(0xe624, fontFamily: 'iconfont'), 'Food', iconText: '0'),
                        ),
                        Expanded(
                          flex: 1,
                          child: _buildButtonColumn(context, IconData(0xe625, fontFamily: 'iconfont'), 'Parcel', iconText: '0'),
                        ),
                        Expanded(
                          flex: 1,
                          child: _buildButtonColumn(context, IconData(0xe626, fontFamily: 'iconfont'), 'Order Bidding'),
                        ),
                        Expanded(
                          flex: 1,
                          child: _buildButtonColumn(context, IconData(0xe630, fontFamily: 'iconfont'), 'Scan'),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                    child: Container(
                      color: Colors.white,
                      height: 240,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _buildSecondaryButtonColumn(context, IconData(0xe62c, fontFamily: 'iconfont'), 'Latest news'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildSecondaryButtonColumn(context, null, 'Acceptance rate',  iconText: '100%', iconTextColor: Colors.green[300]),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildSecondaryButtonColumn(context, IconData(0xe621, fontFamily: 'iconfont'), 'Unaccepted order record'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildSecondaryButtonColumn(context, IconData(0xe7ff, fontFamily: 'iconfont'), 'Hotspot'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _buildSecondaryButtonColumn(context, IconData(0xe62f, fontFamily: 'iconfont'), 'Task statistics'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildSecondaryButtonColumn(context, IconData(0xe7b4, fontFamily: 'iconfont'), 'Referral'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildSecondaryButtonColumn(context, IconData(0xe632, fontFamily: 'iconfont'), 'Incentive'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildSecondaryButtonColumn(context, IconData(0xe62d, fontFamily: 'iconfont'), 'Schedule'),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _buildSecondaryButtonColumn(context, IconData(0xe638, fontFamily: 'iconfont'), 'Assessment'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildSecondaryButtonColumn(context, IconData(0xe62a, fontFamily: 'iconfont'), 'HandBook'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildSecondaryButtonColumn(context, IconData(0xe637, fontFamily: 'iconfont'), 'Contact us'),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: _buildSecondaryButtonColumn(context, IconData(0xe815, fontFamily: 'iconfont'), 'Parcel reconciliation'),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                          height: 50,
                          child: RaisedButton(
                            color: Colors.red,
                            onPressed: () => Scaffold.of(context)
                                .showSnackBar(SnackBar(content: Text('Online Tap'))),
                            child: Text(
                              "Online",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                    )
                  ]
              )
          )
        ],
      ),
    );
  }
}