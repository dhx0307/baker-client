import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class UploadingGameDataView extends StatefulWidget {
  const UploadingGameDataView({super.key});

  @override
  State<UploadingGameDataView> createState() =>
      _UploadingGameDataViewState();
}

class _UploadingGameDataViewState extends State<UploadingGameDataView> {
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
        width: Get.width,
        padding: EdgeInsets.fromLTRB(38, 52, 38, 0),
        child: Column(
          children: [
            Text(
              "比赛结束，数据已保存，是否上传数据？",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 116,),
            Image.asset("images/bg_uploading.png",width: 114,fit: BoxFit.contain,),
            SizedBox(height: 138,),
            GestureDetector(
              onTap: () {
              },
              child: Container(
                  width: 200,
                  height: 52,
                  child: Image.asset(
                    "images/uploading.png",
                    width: 200,
                    fit: BoxFit.contain,
                  )),
            ),
            SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () {
              },
              child: Container(
                width: 200,
                height: 52,
                child: Image.asset("images/noUploading.png",
                    width: 200, fit: BoxFit.contain),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
