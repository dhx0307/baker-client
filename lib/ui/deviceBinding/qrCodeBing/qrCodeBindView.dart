import 'package:bakersoccer/ui/deviceBinding/qrCodeBing/qrScannerView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/log.dart';
import '../../../utils/permission/permission_utils.dart';
import '../../../utils/style/textStyle.dart';
import '../../../utils/toastUtil.dart';
import '../idBind/idBindView.dart';

class QrCodeBindView extends StatefulWidget {
  const QrCodeBindView({super.key});

  @override
  State<QrCodeBindView> createState() => _QrCodeBindViewState();
}

class _QrCodeBindViewState extends State<QrCodeBindView> {
  final _permission = PermissionUtils();
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
        height: Get.height,
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/lanya.png",width: 9.57,fit: BoxFit.contain,),
                SizedBox(width: 2,),
                Text("蓝牙已连接",style: AllTextStyle.f12White,)
              ],
            ),
            SizedBox(height: 60,),
            GestureDetector(
                onTap: () async {
                  Get.snackbar("权限说明", "当您使用APP时，会在二维码绑定时使用相机权限，不授权上述权限，无法绑定设备。",
                      duration: Duration(days: 1),backgroundColor: Colors.white);
                  var status = await _permission.requestCameraPermissions();
                  if (status == true) {
                    Get.back();
                    String? scanResult = await Get.to(() => QrScannerView(),
                        transition: Transition.rightToLeft);
                    if (scanResult != null) {
                      log.i("scanResult:$scanResult");
                      /// TODO 执行后续通过二维码结果绑定设备逻辑
                    }

                  } else {
                    Get.back();
                    ToastUtil.showSimpleToast(
                        '沒有相机权限，请到设置中打开');
                  }
                },
              child: Image.asset("images/qrcode.png",width: 162,fit: BoxFit.contain,),
            ),

            SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => IdBindView(),
                    transition: Transition.rightToLeft);
              },
              child: Image.asset("images/idBind.png",width: 162,fit: BoxFit.contain,),
            ),

          ],
        ),
      ),
    );
  }
}
