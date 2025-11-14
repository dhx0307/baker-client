import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/animatedLines.dart';
import '../measureBallPlaceFinish/measureBallPlaceFinishView.dart';

class MeasureBallPlaceingView extends StatefulWidget {
  const MeasureBallPlaceingView({super.key});

  @override
  State<MeasureBallPlaceingView> createState() =>
      _MeasureBallPlaceingViewState();
}

class _MeasureBallPlaceingViewState extends State<MeasureBallPlaceingView> {
  bool showLine = false; // 是否展示线段
  bool showALight = false;
  bool showBLight = false;
  bool showCLight = false;
  bool showDLight = false;
  bool showELight = false;
  bool showFLight = false;
  late List<Offset> points = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(16, 16, 16, 1),
        resizeToAvoidBottomInset: true,
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
        body: SingleChildScrollView(
          child: Container(
            width: Get.width,
            // height: Get.height,
            padding: EdgeInsets.fromLTRB(23, 36, 23, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "请依次行走至图示球场位置",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 14),
                    ),
                    Text(
                      "A-F",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 231, 0, 1), fontSize: 14),
                    ),
                    Text(
                      "处，",
                      style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 14),
                    ),
                  ],
                ),
                Text("并点击对应节点确认",
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1), fontSize: 14)),
                SizedBox(
                  height: 50,
                ),
                Stack(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      child: Image.asset(
                        "images/bg_qiuchang.png",
                        width: 306,
                        fit: BoxFit.contain,
                      ),
                    ),
                    // 自定义绘制线层
                    if (showLine)
                      Positioned.fill(
                        child: AnimatedLines(
                          points: points,
                          color: Color.fromRGBO(226, 6, 19, 0.5),
                          strokeWidth: 4,
                          duration: Duration(seconds: 1),
                        ),
                      ),
                    Positioned(
                        left: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            points = [
                              Offset(14, 0+13),
                              Offset(89+13+12, 0+13),
                              Offset(179+13+12, 0+13),
                              Offset(280+13+12, 0+13),
                              Offset(280+13+12, 0+13+170+16),
                              Offset(14, 0+13+170+16),
                              Offset(14, 0+13),
                            ];
                            setState(() {
                              showALight = true;
                              showLine = true;
                            });

                            Future.delayed(Duration(seconds: 1), () {
                              Get.to(() => MeasureBallPlaceFinishView(),
                                  transition: Transition.rightToLeft);
                            });

                          },
                          child: showALight == true? Image.asset(
                            "images/a_light.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ) : Image.asset(
                            "images/a.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ),
                        )),
                    Positioned(
                        left: 109,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            points = [
                              Offset(14, 0+13),
                              Offset(109+12, 0+13),
                            ];

                            setState(() {
                              showBLight = true;
                              showLine = true;
                            });

                          },
                          child: showBLight == true? Image.asset(
                            "images/b_light.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ) : Image.asset(
                            "images/b.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ),
                        )),
                    Positioned(
                        right: 109,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            points = [
                              Offset(14, 0+13),
                              Offset(109+12, 0+13),
                              Offset(109+12+66, 0+13),
                            ];
                            setState(() {
                              showCLight = true;
                              showLine = true;
                            });

                          },
                          child: showCLight == true? Image.asset(
                            "images/c_light.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ) : Image.asset(
                            "images/c.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ),
                        )),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            points = [
                              Offset(14, 0+13),
                              Offset(89+13+12, 0+13),
                              Offset(179+13+12, 0+13),
                              Offset(280+13+12, 0+13),
                            ];
                            setState(() {
                              showDLight = true;
                              showLine = true;
                            });
                          },
                          child: showDLight == true? Image.asset(
                            "images/d_light.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ) : Image.asset(
                            "images/d.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ),
                        )),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            points = [
                              Offset(14, 0+13),
                              Offset(89+13+12, 0+13),
                              Offset(179+13+12, 0+13),
                              Offset(280+13+12, 0+13),
                              Offset(280+13+12, 0+13+170+13),
                            ];
                            setState(() {
                              showELight = true;
                              showLine = true;
                            });
                          },
                          child: showELight == true? Image.asset(
                            "images/e_light.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ) : Image.asset(
                            "images/e.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ),
                        )),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: () {
                            points = [
                              Offset(14, 0+13),
                              Offset(89+13+12, 0+13),
                              Offset(179+13+12, 0+13),
                              Offset(280+13+12, 0+13),
                              Offset(280+13+12, 0+13+170+16),
                              Offset(14, 0+13+170+16),
                            ];
                            setState(() {
                              showFLight = true;
                              showLine = true;
                            });
                          },
                          child: showFLight == true? Image.asset(
                            "images/f_light.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ) : Image.asset(
                            "images/f.png",
                            width: 24,
                            fit: BoxFit.contain,
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 87,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.to(() => MeasureBallPlaceingView(), transition: Transition.rightToLeft);
                  },
                  child: Container(
                      width: 200,
                      height: 52,
                      child: Image.asset(
                        "images/measureing.png",
                        width: 200,
                        fit: BoxFit.contain,
                      )),
                ),
                SizedBox(
                  height: 26,
                ),
                GestureDetector(
                  onTap: () {
                    // Get.to(() => MeasureBallPlaceingView(), transition: Transition.rightToLeft);
                  },
                  child: Container(
                    width: 200,
                    height: 52,
                    child: Image.asset("images/cancelMeasure.png",
                        width: 200, fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
