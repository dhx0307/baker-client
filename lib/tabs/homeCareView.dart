import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chart_plus/flutter_chart.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:permission_handler/permission_handler.dart';
import '../ui/homeCare/gameData/gameDataView.dart';
import '../utils/log.dart';
import '../utils/notifications/notifications.dart';
import '../utils/permission/permission_utils.dart';
import '../utils/toastUtil.dart';

class HomeCareView extends StatefulWidget {
  const HomeCareView({super.key});

  @override
  State<HomeCareView> createState() => _HomeCareViewState();
}

class _HomeCareViewState extends State<HomeCareView> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final _permission = PermissionUtils();
  @override
  Widget build(BuildContext context) {
    final List<Map> dataList = [
      {
        'title': "SHT",
        'value1': 80.2,
      },
      {
        'title': "PAS",
        'value1': 86.7,
      },
      {
        'title': "DEF",
        'value1': 76.3,
      },
      {
        'title': "PHY",
        'value1': 61.5,
      },
      {
        'title': "SPD",
        'value1': 82,
      },
      {
        'title': "DRI",
        'value1': 100,
      },
    ];
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: ListView(
          children: [
            Container(
              height: 192,
              padding: EdgeInsets.fromLTRB(17, 14, 17, 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                image: DecorationImage(
                  image: AssetImage('images/bg_totalScore.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 172,
                      height: 164,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/bg_radar1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: ChartWidget(
                        coordinateRender: ChartCircularCoordinateRender(
                          margin: const EdgeInsets.all(10),
                          charts: [
                            Radar(
                              max: 150,
                              data: dataList,
                              lineColor: Colors.transparent,
                              colors: [Colors.transparent],
                              fillColors: [Colors.white],
                              // legendFormatter: () => dataList.map((e) => e['title']).toList(),
                              // count: 3,
                              valueFormatter: (item) => [
                                item['value1'],
                              ],
                              values: (item) => [
                                (double.parse(item['value1'].toString())),
                              ],
                            ),
                          ],
                          borderColor: Colors.transparent,
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Total score",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "总评分",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "86.1",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          Text(
                            "场次：",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "25",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    Get.to(() => GameDataView(),
                        transition: Transition.rightToLeft);
                  },
                  child: Container(
                      width: 249,
                      height: 128,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        image: DecorationImage(
                          image: AssetImage('images/bg_zuijia.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'images/qingtian.png',
                                        fit: BoxFit.contain,
                                        width: 9,
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        "05/13",
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        "虹口足球场",
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'images/shijian.png',
                                        fit: BoxFit.contain,
                                        width: 9,
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        "00:56:12",
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Image.asset(
                                'images/bg_game.png',
                                fit: BoxFit.contain,
                                width: 93,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "92.1",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "站位：",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "LB",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "惯用脚：",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "右脚",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      )),
                )),
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    showNotification();

                    _notificationHelper.startDynamicNotification();
                  },
                  child: Container(
                    width: 86,
                    height: 128,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      image: DecorationImage(
                        image: AssetImage('images/bg_start.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  _checkNotificationPermission() async {
    // 对于iOS，直接请求通知权限
    if (Platform.isIOS) {
      return await _permission.requestNotificationPermissions();
    }
    // 对于Android，根据API级别处理
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      print(androidInfo.version.sdkInt);

      // Android 13及以上（API 33+）需要显式请求通知权限
      if (androidInfo.version.sdkInt >= 33) {
        Get.snackbar("权限说明", "当您使用APP时，会在开始比赛时向您推送比赛消息，不授权上述权限，不影响APP其他功能使用。",
            duration: Duration(days: 1),backgroundColor: Colors.white);
        var res = await _permission.requestNotificationPermissions();
        if (res) {
          Get.back();
        } else {
          Get.back();
          Get.snackbar(
            "权限被拒绝",
            "没有通知权限，您将无法收到通知消息",
            duration: const Duration(seconds: 2),
          );
        }
        return res;
      } else {
        // Android 12及以下，通知权限在安装时自动授予
        return true;
      }
    }
    return false;
  }

  void showNotification() async {
    await _checkNotificationPermission();
    _notificationHelper.showNotification(
      id: 4,
      title: 'Hello',
      body: 'This is a notification!',
    );

  }

}
