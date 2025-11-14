import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/log.dart';
import '../../../utils/style/textStyle.dart';
import '../qrCodeBing/qrCodeBindView.dart';

class BlueToothBindView extends StatefulWidget {
  const BlueToothBindView({super.key});

  @override
  State<BlueToothBindView> createState() => _BlueToothBindViewState();
}

class _BlueToothBindViewState extends State<BlueToothBindView>
    with WidgetsBindingObserver {
  // 标记是否是从设置页面返回（避免初始化时触发）
  bool _isFromSettings = false;
  bool _isConnectBlueTooth = true;

  @override
  void initState() {
    super.initState();
    // 注册生命周期监听
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // 移除监听，避免内存泄漏
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // 生命周期状态变化时触发
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // 当应用从后台返回前台（用户从设置页面返回）
    if (state == AppLifecycleState.resumed && _isFromSettings) {
      // 执行需要的请求（例如检测蓝牙状态、调用接口等）
      _executeAfterReturn();
      // 重置标记，避免重复触发
      _isFromSettings = false;
    }
  }

  // 从设置返回后执行的操作
  void _executeAfterReturn() {
    log.i("从设置返回，执行请求...");
    // 实际场景中可替换为接口请求：
    // await api.sendRequest();
    // 或蓝牙状态检测等逻辑
    if (_isConnectBlueTooth) {
      /// 设备蓝牙链接成功之后跳转
      Get.to(() => QrCodeBindView(), transition: Transition.rightToLeft);
    } else {

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 16, 16, 1),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Image.asset(
              "images/back.png",
              width: 10,
              fit: BoxFit.contain,
            )),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(87, 54, 87, 0),
        child: Column(
          children: [
            // 蓝牙状态提示（false显示提示，true显示同等高度空容器）
            _isConnectBlueTooth
                ? Container(height: 14) // 与原Row高度一致（图标9.57 + 文字行高≈14，保持布局不偏移）
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/lanya.png",
                  width: 9.57,
                  fit: BoxFit.contain,
                  color: Color.fromRGBO(226, 6, 19, 1),
                ),
                SizedBox(width: 2),
                Text(
                  "蓝牙未连接",
                  style: AllTextStyle.f12Red,
                )
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Image.asset(
              "images/blueTooth.png",
              width: 170,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 128,
            ),
            GestureDetector(
              onTap: () {
                // 标记即将跳转到设置页面
                _isFromSettings = true;
                AppSettings.openAppSettings(type: AppSettingsType.bluetooth);
              },
              child: Container(
                width: 200,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(28)),
                  image: DecorationImage(
                    image: AssetImage('images/bg_login.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: Text('开启蓝牙', style: AllTextStyle.f20Black),
                ),
              ),
            ),
            SizedBox(
              height: 26,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                  width: 200,
                  height: 52,
                  child: Image.asset(
                    "images/quitBind.png",
                    width: 200,
                    fit: BoxFit.contain,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
