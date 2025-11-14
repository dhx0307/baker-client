import 'package:bakersoccer/utils/style/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../utils/log.dart';
import '../DeviceBindinging/deviceBindingingView.dart';

class IdBindView extends StatefulWidget {
  const IdBindView({super.key});

  @override
  State<IdBindView> createState() => _IdBindViewState();
}

class _IdBindViewState extends State<IdBindView> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNodeIDCode = FocusNode();

  _submitted(v) async {
    log.i("ID:$v");
    /// TODO 跳转到设备绑定
    Get.to(() => DeviceBindingingView(), transition: Transition.rightToLeft);
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
        title: Text("输入设备ID",style: AllTextStyle.f14White,),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("请输入设备ID",style: AllTextStyle.f12White,),
            SizedBox(height: 20,),
            Container(
              height: 67,
              child: PinCodeTextField(
                appContext: context,
                controller: textEditingController,
                focusNode: focusNodeIDCode,
                length: 6,
                keyboardType: TextInputType.number,
                showCursor: true,
                cursorColor: const Color.fromRGBO(128, 128, 128, 1),
                cursorWidth: 1,
                cursorHeight: 30,
                animationType: AnimationType.scale,
                autoFocus: true,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                enableActiveFill: true,
                // 核心样式配置
                pinTheme: PinTheme(
                  // 基础样式（未选中状态）
                  shape: PinCodeFieldShape.box,
                  fieldHeight: 67,      // 高度
                  fieldWidth: 46,       // 宽度
                  borderRadius: BorderRadius.circular(8),
                  activeFillColor: const Color.fromRGBO(54, 54, 54, 1), // 输入后的填充色
                  activeColor: Colors.transparent,
                  // 选中状态样式（光标所在位置）
                  selectedColor: Colors.transparent,  // 选中边框色（透明处理）
                  selectedFillColor: const Color.fromRGBO(32, 32, 32, 1), // 选中背景
                  // 未输入状态样式
                  inactiveFillColor: const Color.fromRGBO(54, 54, 54, 1), // 未选中且未输入
                  inactiveColor: Colors.transparent, // 去除未选中时的边框
                ),
                textStyle: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w600
                ),
                onCompleted: (v) {
                  _submitted(v);
                },

              )
            )

          ],
        ),
      ),
    );
  }
}
