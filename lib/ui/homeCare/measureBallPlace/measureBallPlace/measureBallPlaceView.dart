import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../measureBallPlaceing/measureBallPlaceingView.dart';
import '../selectBallPark/selectBallParkView.dart';

class MeasureBallPlaceView extends StatefulWidget {
  const MeasureBallPlaceView({super.key});

  @override
  State<MeasureBallPlaceView> createState() => _MeasureBallPlaceViewState();
}

class _MeasureBallPlaceViewState extends State<MeasureBallPlaceView> {
  TextEditingController _ballPlaceController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.dispose();
    super.dispose();
  }

  _changeBall(String v) {

  }

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
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => SelectBallParkView(),
                      transition: Transition.rightToLeft);
                },
                icon: Image.asset(
                  "images/qiuchang.png",
                  width: 18,
                  fit: BoxFit.contain,
                )),
          ],
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
                    Positioned(
                        left: 0,
                        top: 0,
                        child: Image.asset(
                          "images/a.png",
                          width: 24,
                          fit: BoxFit.contain,
                        )),
                    Positioned(
                        left: 109,
                        top: 0,
                        child: Image.asset(
                          "images/b.png",
                          width: 24,
                          fit: BoxFit.contain,
                        )),
                    Positioned(
                        right: 109,
                        top: 0,
                        child: Image.asset(
                          "images/c.png",
                          width: 24,
                          fit: BoxFit.contain,
                        )),
                    Positioned(
                        right: 0,
                        top: 0,
                        child: Image.asset(
                          "images/d.png",
                          width: 24,
                          fit: BoxFit.contain,
                        )),
                    Positioned(
                        right: 0,
                        bottom: 0,
                        child: Image.asset(
                          "images/e.png",
                          width: 24,
                          fit: BoxFit.contain,
                        )),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: Image.asset(
                          "images/f.png",
                          width: 24,
                          fit: BoxFit.contain,
                        )),
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _ballPlaceController,
                    focusNode: _focusNode,
                    autofocus: false,
                    cursorColor: Color.fromRGBO(226, 6, 19, 1),
                    style: TextStyle(color: Colors.white),
                    onChanged: (v) => _changeBall(v),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "请输入球场名称",
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(255, 255, 255, 1)),
                      counterText: '',
                      enabledBorder: UnderlineInputBorder(
                        // 默认状态下的下划线
                        borderSide:
                            BorderSide(color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        // 获取焦点时的下划线
                        borderSide:
                            BorderSide(color: Color.fromRGBO(226, 6, 19, 1)),
                      ),
                    )),
                SizedBox(
                  height: 100,
                ),
                GestureDetector(
                  onTap: () {
                    _focusNode.unfocus();
                    Get.to(() => MeasureBallPlaceingView(),
                        transition: Transition.rightToLeft);
                  },
                  child: Container(
                    width: 200,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      image: DecorationImage(
                        image: AssetImage('images/bg_login.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '开始测量',
                        style: TextStyle(
                          color: Color.fromRGBO(16, 16, 16, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
