import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/log.dart';
import '../uploadingGameData/uploadingGameDataView.dart';



class BeginBallGameingView extends StatefulWidget {
  const BeginBallGameingView({super.key});

  @override
  State<BeginBallGameingView> createState() => _BeginBallGameingViewState();
}

class _BeginBallGameingViewState extends State<BeginBallGameingView> {
  int _secondsElapsed = 0;
  late Timer _timer;
  bool _isRunning = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    log.i("_secondsElapsed:$_secondsElapsed");
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed++;
      });
      log.i("_secondsElapsed:$_secondsElapsed");
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _pauseTimer() {
    _timer.cancel();
    setState(() {
      _isRunning = false;
    });
    log.i("暂停比赛");
  }

  void _resetTimer() {
    _timer.cancel();
    setState(() {
      _secondsElapsed = 0;
      _isRunning = false;
    });
    log.i("结束比赛");
  }

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = remainingSeconds.toString().padLeft(2, '0');

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(16, 16, 16, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(28, 28, 28, 1),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset(
                "images/back.png",
                width: 10,
                fit: BoxFit.contain,
              )),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "images/a-xinpianshuju.png",
                width: 14,
                fit: BoxFit.contain,
                color: Colors.white,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                "设备工作中···",
                style: TextStyle(fontSize: 14, color: Colors.white),
              )
            ],
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(30)),
              child: Container(
                padding: EdgeInsets.fromLTRB(25, 5, 25, 27),
                color: const Color.fromRGBO(28, 28, 28, 1),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 96,
                          height: 42,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(49, 49, 49, 1),
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "images/kaiji1.png",
                                    width: 12,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "电量",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                "56%",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 136,
                          height: 42,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(49, 49, 49, 1),
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "images/lianjie1.png",
                                    width: 12,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "连接状态",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                "已连接",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 106,
                          height: 42,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(49, 49, 49, 1),
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "images/wifi1.png",
                                    width: 12,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "WIFI",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                "已连接",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 110,
                          height: 42,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(49, 49, 49, 1),
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "images/gps1.png",
                                    width: 12,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "GPS",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                "已连接",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 90,
                          height: 42,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(49, 49, 49, 1),
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "images/wendu1.png",
                                    width: 8,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "温度",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                "正常",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 94,
                          height: 42,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(49, 49, 49, 1),
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "images/fengli.png",
                                    width: 12,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "风力",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                "三级",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 94,
                          height: 42,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(49, 49, 49, 1),
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "images/tianqi.png",
                                    width: 12,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "天气",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                "多云",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 94,
                          height: 42,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(49, 49, 49, 1),
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "images/wendu1.png",
                                    width: 8,
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "气温",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                              Text(
                                "26℃",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(25, 20, 25, 28),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'images/bg_timer.png',
                    height: 154,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    _formatTime(_secondsElapsed),
                    style: TextStyle(
                        fontSize: 62, color: Color.fromRGBO(49, 49, 49, 1)),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                _pauseTimer();
              },
              child: Container(
                  width: 124,
                  height: 124,
                  child: Image.asset(
                    "images/pauseTimer.png",
                    width: 124,
                    fit: BoxFit.contain,
                  )),
            ),
            SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () {
                _resetTimer();

                /// TODO 暂时添加跳转逻辑
                Get.to(() => UploadingGameDataView(),
                    transition: Transition.rightToLeft);
              },
              child: Container(
                width: 124,
                height: 124,
                child: Image.asset("images/overTimer.png",
                    width: 124, fit: BoxFit.contain),
              ),
            ),
          ],
        ));
  }
}
