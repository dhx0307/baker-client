import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../beginBallGame/beginBallGameView.dart';

class MeasureBallPlaceFinishView extends StatefulWidget {
  const MeasureBallPlaceFinishView({super.key});

  @override
  State<MeasureBallPlaceFinishView> createState() => _MeasureBallPlaceFinishViewState();
}

class _MeasureBallPlaceFinishViewState extends State<MeasureBallPlaceFinishView> {
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
          padding: EdgeInsets.fromLTRB(23, 56, 23, 0),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Image.asset(
                      "images/bg_qiuchang_light.png",
                      width: 306,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                      left: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(
                          "images/a_light.png",
                          width: 24,
                          fit: BoxFit.contain,
                        ),
                      )),
                  Positioned(
                      left: 109,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(
                          "images/b_light.png",
                          width: 24,
                          fit: BoxFit.contain,
                        ),
                      )),
                  Positioned(
                      right: 109,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(
                          "images/c_light.png",
                          width: 24,
                          fit: BoxFit.contain,
                        ),
                      )),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(
                          "images/d_light.png",
                          width: 24,
                          fit: BoxFit.contain,
                        ),
                      )),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(
                          "images/e_light.png",
                          width: 24,
                          fit: BoxFit.contain,
                        ),
                      )),
                  Positioned(
                      left: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: Image.asset(
                          "images/f_light.png",
                          width: 24,
                          fit: BoxFit.contain,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 65,
              ),
              Image.asset("images/finish.png", width: 50,
                fit: BoxFit.contain,),
              SizedBox(
                height: 12,
              ),
              Text("测量完成",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
              SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => BeginBallGameView(), transition: Transition.rightToLeft);
                },
                child: Container(
                  width: 200,
                  height: 52,
                  child: Image.asset("images/beginPlay.png",
                      width: 200, fit: BoxFit.contain),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 200,
                  height: 52,
                  child: Image.asset("images/rMeasure.png",
                      width: 200, fit: BoxFit.contain),
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}
