import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utils/log.dart';
import '../deviceBinding/deviceBinding.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  TextEditingController _nickNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _sexController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  TextEditingController _signController = TextEditingController();
  TextEditingController _teamController = TextEditingController();
  TextEditingController _footballerController = TextEditingController();
  TextEditingController _ballparkController = TextEditingController();
  TextEditingController _positionController = TextEditingController();
  TextEditingController _dominantFootController = TextEditingController();
  FocusNode _sexFocusNode = FocusNode();
  String? birth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(16, 16, 16, 1),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(71, 81, 71, 43),
                // height: Get.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      // 添加 Center 组件
                      child: Image.asset(
                        "images/avatar.png",
                        width: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 34,
                    ),
                    Form(
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          children: [
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _nickNameController,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                // onChanged: (v) => _changenickName(v),
                                decoration: InputDecoration(
                                  hintText: "昵称",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(140, 140, 140, 1)),
                                  counterText: '',
                                  filled: true,
                                  // 必须设置为true才能显示背景色
                                  fillColor: Colors.transparent,
                                  // 背景色（透明或你需要的颜色）
                                  // 圆角边框设置
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide:
                                        BorderSide.none, // 无边框线（如果需要边框线可以设置颜色）
                                  ),
                                  // 禁用状态样式
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 聚焦状态样式
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(226, 6, 19, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 内容内边距
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _ageController,
                                readOnly: true,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                // onChanged: (v) => _changenickName(v),
                                onTap: () {
                                  Pickers.showDatePicker(context,
                                      pickerStyle: PickerStyle(
                                          commitButton: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 22),
                                        child: Text('确定',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0)),
                                      )), onConfirm: (v) {
                                    // 使用 DateFormat 格式化日期
                                    DateTime selectedDate =
                                        DateTime(v.year!, v.month!, v.day!);
                                    String formattedDate =
                                        DateFormat('yyyy-MM-dd')
                                            .format(selectedDate);
                                    log.i("格式化后的日期: $formattedDate");
                                    setState(() {
                                      birth = formattedDate;
                                      _ageController.text = birth!;
                                    });
                                    _sexFocusNode.requestFocus();

                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "年龄",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(140, 140, 140, 1)),
                                  counterText: '',
                                  filled: true,
                                  // 必须设置为true才能显示背景色
                                  fillColor: Colors.transparent,
                                  // 背景色（透明或你需要的颜色）
                                  // 圆角边框设置
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide:
                                        BorderSide.none, // 无边框线（如果需要边框线可以设置颜色）
                                  ),
                                  // 禁用状态样式
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 聚焦状态样式
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(226, 6, 19, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 内容内边距
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _sexController,
                                focusNode: _sexFocusNode,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                // onChanged: (v) => _changenickName(v),
                                decoration: InputDecoration(
                                  hintText: "性别",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(140, 140, 140, 1)),
                                  counterText: '',
                                  filled: true,
                                  // 必须设置为true才能显示背景色
                                  fillColor: Colors.transparent,
                                  // 背景色（透明或你需要的颜色）
                                  // 圆角边框设置
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide:
                                        BorderSide.none, // 无边框线（如果需要边框线可以设置颜色）
                                  ),
                                  // 禁用状态样式
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 聚焦状态样式
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(226, 6, 19, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 内容内边距
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _heightController,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                // onChanged: (v) => _changenickName(v),
                                decoration: InputDecoration(
                                  hintText: "身高",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(140, 140, 140, 1)),
                                  counterText: '',
                                  filled: true,
                                  // 必须设置为true才能显示背景色
                                  fillColor: Colors.transparent,
                                  // 背景色（透明或你需要的颜色）
                                  // 圆角边框设置
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide:
                                        BorderSide.none, // 无边框线（如果需要边框线可以设置颜色）
                                  ),
                                  // 禁用状态样式
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 聚焦状态样式
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(226, 6, 19, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 内容内边距
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _weightController,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                // onChanged: (v) => _changenickName(v),
                                decoration: InputDecoration(
                                  hintText: "体重",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(140, 140, 140, 1)),
                                  counterText: '',
                                  filled: true,
                                  // 必须设置为true才能显示背景色
                                  fillColor: Colors.transparent,
                                  // 背景色（透明或你需要的颜色）
                                  // 圆角边框设置
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide:
                                        BorderSide.none, // 无边框线（如果需要边框线可以设置颜色）
                                  ),
                                  // 禁用状态样式
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 聚焦状态样式
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(226, 6, 19, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 内容内边距
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _signController,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                // onChanged: (v) => _changenickName(v),
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: "个签",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(140, 140, 140, 1)),
                                  counterText: '',
                                  filled: true,
                                  // 必须设置为true才能显示背景色
                                  fillColor: Colors.transparent,
                                  // 背景色（透明或你需要的颜色）
                                  // 圆角边框设置
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide:
                                        BorderSide.none, // 无边框线（如果需要边框线可以设置颜色）
                                  ),
                                  // 禁用状态样式
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 聚焦状态样式
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(226, 6, 19, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 内容内边距
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _teamController,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                // onChanged: (v) => _changenickName(v),
                                decoration: InputDecoration(
                                  hintText: "喜爱球队",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(140, 140, 140, 1)),
                                  counterText: '',
                                  filled: true,
                                  // 必须设置为true才能显示背景色
                                  fillColor: Colors.transparent,
                                  // 背景色（透明或你需要的颜色）
                                  // 圆角边框设置
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide:
                                        BorderSide.none, // 无边框线（如果需要边框线可以设置颜色）
                                  ),
                                  // 禁用状态样式
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 聚焦状态样式
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(226, 6, 19, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 内容内边距
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _footballerController,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                // onChanged: (v) => _changenickName(v),
                                decoration: InputDecoration(
                                  hintText: "喜爱球员",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(140, 140, 140, 1)),
                                  counterText: '',
                                  filled: true,
                                  // 必须设置为true才能显示背景色
                                  fillColor: Colors.transparent,
                                  // 背景色（透明或你需要的颜色）
                                  // 圆角边框设置
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide:
                                        BorderSide.none, // 无边框线（如果需要边框线可以设置颜色）
                                  ),
                                  // 禁用状态样式
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 聚焦状态样式
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(226, 6, 19, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 内容内边距
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _ballparkController,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                // onChanged: (v) => _changenickName(v),
                                decoration: InputDecoration(
                                  hintText: "喜爱球场",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(140, 140, 140, 1)),
                                  counterText: '',
                                  filled: true,
                                  // 必须设置为true才能显示背景色
                                  fillColor: Colors.transparent,
                                  // 背景色（透明或你需要的颜色）
                                  // 圆角边框设置
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide:
                                        BorderSide.none, // 无边框线（如果需要边框线可以设置颜色）
                                  ),
                                  // 禁用状态样式
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 聚焦状态样式
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(226, 6, 19, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 内容内边距
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _positionController,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                // onChanged: (v) => _changenickName(v),
                                decoration: InputDecoration(
                                  hintText: "站位",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(140, 140, 140, 1)),
                                  counterText: '',
                                  filled: true,
                                  // 必须设置为true才能显示背景色
                                  fillColor: Colors.transparent,
                                  // 背景色（透明或你需要的颜色）
                                  // 圆角边框设置
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide:
                                        BorderSide.none, // 无边框线（如果需要边框线可以设置颜色）
                                  ),
                                  // 禁用状态样式
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 聚焦状态样式
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(226, 6, 19, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 内容内边距
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                )),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _dominantFootController,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                // onChanged: (v) => _changenickName(v),
                                decoration: InputDecoration(
                                  hintText: "惯用脚",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(140, 140, 140, 1)),
                                  counterText: '',
                                  filled: true,
                                  // 必须设置为true才能显示背景色
                                  fillColor: Colors.transparent,
                                  // 背景色（透明或你需要的颜色）
                                  // 圆角边框设置
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide:
                                        BorderSide.none, // 无边框线（如果需要边框线可以设置颜色）
                                  ),
                                  // 禁用状态样式
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 聚焦状态样式
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    borderSide: BorderSide(
                                      color: Color.fromRGBO(226, 6, 19, 1),
                                      width: 1.0,
                                    ),
                                  ),
                                  // 内容内边距
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 12.0,
                                  ),
                                )),
                            SizedBox(
                              height: 40,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => DeviceBinding(),
                                    transition: Transition.rightToLeft);
                              },
                              child: Image.asset(
                                "images/next.png",
                                width: 40,
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
