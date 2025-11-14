import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/style/textStyle.dart';
import '../blueToothBind/blueToothBindView.dart';

class BeginBindDeviceView extends StatefulWidget {
  const BeginBindDeviceView({super.key});

  @override
  State<BeginBindDeviceView> createState() => _BeginBindDeviceViewState();
}

class _BeginBindDeviceViewState extends State<BeginBindDeviceView> {
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
        padding: EdgeInsets.fromLTRB(87, 115, 87, 0),
        child: Column(
          children: [
            Image.asset("images/deviceBind.png",width: 196,fit: BoxFit.contain,),
            SizedBox(
              height: 110,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => BlueToothBindView(),
                    transition: Transition.rightToLeft);
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
                  child: Text(
                    '开始绑定',
                    style: AllTextStyle.f20Black
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: () {},
              child: Text("了解产品",style: AllTextStyle.f12White,),
            )
          ],
        ),
      ),
    );
  }
}
