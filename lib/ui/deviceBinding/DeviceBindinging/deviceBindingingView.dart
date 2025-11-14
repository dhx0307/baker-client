import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/log.dart';
import '../../homeCare/measureBallPlace/measureBallPlace/measureBallPlaceView.dart';

class DeviceBindingingView extends StatefulWidget {
  const DeviceBindingingView({super.key});

  @override
  State<DeviceBindingingView> createState() => _DeviceBindingingViewState();
}

class _DeviceBindingingViewState extends State<DeviceBindingingView> {
  Widget getIcon(String iconName) {
    return Image.asset(
      "images/$iconName.png",
      width: 10,
      height: 10,
      color: Color.fromRGBO(16, 16, 16, 1),
      errorBuilder: (context, error, stackTrace) =>
          Icon(Icons.error), // 加载失败时显示错误图标
    );
  }

  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> _list = [
      {
        "icon": "kaiji",
        "title": "电量",
        "status": "发现中",
        "isDiscovered": false, // 是否被发现
        "value": "",
      },
      {
        "icon": "lianjie",
        "title": "连接状态",
        "status": "发现中",
        "isDiscovered": false,
        "isConnected": false, // 是否已连接
      },
      {
        "icon": "wifi",
        "title": "WIFI",
        "status": "发现中",
        "isDiscovered": false,
        "isConnected": false, // 是否已连接
      },
      {
        "icon": "gpsfixed",
        "title": "GPS",
        "status": "发现中",
        "isDiscovered": false,
        "isConnected": false, // 是否已连接
      },
      {
        "icon": "wendu",
        "title": "温度",
        "status": "发现中",
        "isDiscovered": false,
        "value": "正常", // 温度值
      },
    ];

    // 获取状态文本
    String _getStatusText(Map<String, dynamic> item) {
      if (!item["isDiscovered"]) {
        return "未发现";
      } else {
        if (item["title"] == "电量" || item["title"] == "温度") {
          return item["value"]; // 显示电量或温度值
        } else if (item["isConnected"]) {
          return "已连接";
        } else {
          return "未发现"; // 其他情况
        }
      }
    }
    // 获取状态文本颜色
    Color _getStatusColor(Map<String, dynamic> item) {
      if (!item["isDiscovered"]) {
        return Color.fromRGBO(128, 128, 128, 1); // 灰色（未发现）
      } else if (item["isConnected"] ?? false) {
        return Color.fromARGB(70, 181, 84, 1); //（已连接）
      } else {
        return Color.fromRGBO(128, 128, 128, 1); // 黑色（已发现）
      }
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      body: Container(
        padding: EdgeInsets.fromLTRB(44, 44, 44, 0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "images/deviceBindinging.png",
                  width: 103,
                  fit: BoxFit.contain,
                ),
                Image.asset(
                  "images/omit.png",
                  width: 40,
                  fit: BoxFit.contain,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => MeasureBallPlaceView(), transition: Transition.rightToLeft);
                  },
                  child: Image.asset(
                    "images/bg_device.png",
                    width: 103,
                    fit: BoxFit.contain,
                  ),
                )


              ],
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 270,
              padding: EdgeInsets.fromLTRB(26, 59, 26, 26),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bg_leftDevice.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(), // 禁用滚动
                shrinkWrap: true, // 使ListView高度适应内容
                itemCount: _list.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 0.5, color: Color.fromRGBO(16, 16, 16, 0.5)),
                itemBuilder: (context, index) {
                  final item = _list[index];
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 35),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      // 使用紧凑模式减少高度
                      dense: true,
                      // 进一步压缩垂直间距
                      visualDensity: VisualDensity(vertical: -3),
                      leading: getIcon(item["icon"]),
                      // 使用自定义图标
                      title: Transform.translate(offset: Offset(-25, 0),child: Text(
                        item["title"],
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(16, 16, 16, 1),
                            fontWeight: FontWeight.w600),
                      ),),
                      trailing: Text(_getStatusText(item),
                          style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(item))),
                      onTap: () {
                        // 处理点击事件
                        print('点击了: ${item["title"]}');
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 270,
              padding: EdgeInsets.fromLTRB(26, 59, 26, 26),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bg_rightDevice.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: ListView.separated(
                physics: NeverScrollableScrollPhysics(), // 禁用滚动
                shrinkWrap: true, // 使ListView高度适应内容
                itemCount: _list.length,
                separatorBuilder: (context, index) =>
                    Divider(height: 0.5, color: Color.fromRGBO(16, 16, 16, 0.5)),
                itemBuilder: (context, index) {
                  final item = _list[index];
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 35),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      // 使用紧凑模式减少高度
                      dense: true,
                      // 进一步压缩垂直间距
                      visualDensity: VisualDensity(vertical: -3),
                      leading: getIcon(item["icon"]),
                      // 使用自定义图标
                      title: Transform.translate(offset: Offset(-25, 0),child: Text(
                        item["title"],
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(16, 16, 16, 1),
                            fontWeight: FontWeight.w600),
                      ),),
                      trailing: Text(_getStatusText(item),
                          style: TextStyle(
                              fontSize: 12,
                              color: _getStatusColor(item))),
                      onTap: () {
                        // 处理点击事件
                        print('点击了: ${item["title"]}');
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
