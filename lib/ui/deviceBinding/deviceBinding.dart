import 'package:bakersoccer/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'DeviceBindinging/deviceBindingingView.dart';
import 'beginBindDevice/beginBindDeviceView.dart';

class DeviceBinding extends StatefulWidget {
  const DeviceBinding({super.key});

  @override
  State<DeviceBinding> createState() => _DeviceBindingState();
}

class _DeviceBindingState extends State<DeviceBinding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {

              Get.to(() => BeginBindDeviceView(),
                  transition: Transition.rightToLeft);
            },
            child: Image.asset(
              "images/deviceBinding.png",
              width: 162,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 100,
          ),
          GestureDetector(
            onTap: () {
              /// TODO
              Get.to(() => LqHomeCareApp(), transition: Transition.rightToLeft);
            },
            child: Image.asset(
              "images/toHomeCare.png",
              width: 162,
              fit: BoxFit.contain,
            ),
          )
        ],
      )),
    );
  }
}
