import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../beginBallGameing/beginBallGameingView.dart';

class BeginBallGameView extends StatefulWidget {
  const BeginBallGameView({super.key});

  @override
  State<BeginBallGameView> createState() => _BeginBallGameViewState();
}

class _BeginBallGameViewState extends State<BeginBallGameView> {
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
        padding: EdgeInsets.fromLTRB(89, 115, 89, 0),
        child: Column(
          children: [
            Image.asset(
              "images/yiZhunBei.png",
              width: 204,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 110,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => BeginBallGameingView(),
                    transition: Transition.rightToLeft);
              },
              child: Container(
                  width: 200,
                  height: 52,
                  child: Image.asset(
                    "images/beginPlay.png",
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
                child: Image.asset("images/quitGame.png",
                    width: 200, fit: BoxFit.contain),
              ),
            ),
          ],

        ),
      ),
    );
  }
}
