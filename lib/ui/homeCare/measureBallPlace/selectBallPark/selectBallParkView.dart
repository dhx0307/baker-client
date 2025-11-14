import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../beginBallGame/beginBallGameView.dart';

class SelectBallParkView extends StatefulWidget {
  const SelectBallParkView({super.key});

  @override
  State<SelectBallParkView> createState() => _SelectBallParkViewState();
}

class _SelectBallParkViewState extends State<SelectBallParkView> {
  List ballParkList = [
    "深大足球场",
    "浦东足球场",
    "南山足球场",
    "虹口足球场",
    "上海足球场",
  ];
  int? selectedIndex; // 记录当前选中的索引

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
      body: Container(
        padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index; // 更新选中的索引
                    });
                  },
                  child: Container(
                      height: 62,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          // 根据是否选中切换背景图片
                          image: AssetImage(selectedIndex == index
                              ? 'images/bg_selectBallPark_light.png'
                              : 'images/bg_selectBallPark.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: ListTile(
                          leading: Image.asset(
                            "images/icon_ball.png",
                            width: 16,
                            fit: BoxFit.contain,
                          ),
                          title: Text(
                            ballParkList[index],
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          trailing: Image.asset(
                            "images/bianji.png",
                            width: 14,
                            color: selectedIndex == index
                                ? Colors.grey
                                : Colors.white,
                            fit: BoxFit.contain,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(18, 0, 18, 0),
                        ),
                      )),
                );
              },
              itemCount: ballParkList.length,
            )),
            GestureDetector(
              onTap: () {
                if (selectedIndex != null) {
                  Get.to(() => BeginBallGameView(),
                      transition: Transition.rightToLeft);
                }
              },
              child: Container(
                width: 200,
                height: 52,
                margin: EdgeInsets.fromLTRB(0, 100, 0, 142),
                child: Image.asset(
                    selectedIndex != null
                        ? 'images/confirmBallPlace_light.png'
                        : 'images/confirmBallPlace.png',
                    width: 200,
                    fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
