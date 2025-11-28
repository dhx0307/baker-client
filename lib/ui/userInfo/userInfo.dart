import 'package:bakersoccer/ui/userInfo/userInfoLogic.dart';
import 'package:bakersoccer/utils/toastUtil.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../model/userInfo/userInfoData.dart';
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
  TextEditingController _positionController = TextEditingController();
  TextEditingController _dominantFootController = TextEditingController();
  FocusNode _sexFocusNode = FocusNode();
  String? birth;
  int? sex;
  UserInfoLogic? logic;
  UserInfoData? userInfoData = UserInfoData();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logic = Get.put(UserInfoLogic());
    // _getUserInfo();
  }

  // _getUserInfo() async {
  //   UserInfoData res = await logic?.getUserInfo();
  //   log.i("getUserInfo:$res");
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  _changeNickName(String v) {
    setState(() {
      userInfoData?.nickname = v;
    });
  }
  _changeHeight(String v) {
    print("v:$v");
    if (v.isEmpty) {
      return;
    } else {
      setState(() {
        userInfoData?.height = int.parse(v);
      });
    }
    print("userInfoData?.height:${userInfoData?.height}");
  }
  _changeWeight(String v) {
    print("v:$v");
    if (v.isEmpty) {
      return;
    } else {
      setState(() {
        userInfoData?.weight = int.parse(v);
      });
    }
    print("userInfoData?.weight:${userInfoData?.weight}");
  }
  _changeSign(String v) {
    setState(() {
      userInfoData?.sign = v;
    });
  }
  _changeTeam(String v) {
    if (v.isEmpty) {
      return;
    } else {
      setState(() {
        userInfoData?.favTeam = int.parse(v);
      });
    }
  }
  _changeFootballer(String v) {
    if (v.isEmpty) {
      return;
    } else {
      setState(() {
        userInfoData?.favPlayer = int.parse(v);
      });
    }
  }
  _changePos(String v) {
    if (v.isEmpty) {
      return;
    } else {
      setState(() {
        userInfoData?.pos = int.parse(v);
      });
    }
  }
  _changeFeet(String v) {
    if (v.isEmpty) {
      return;
    } else {
      setState(() {
        userInfoData?.feet = int.parse(v);
      });
    }
  }

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
                                onChanged: (v) => _changeNickName(v),
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
                                      userInfoData?.birth = birth;
                                    });
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
                                readOnly: true,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                // onChanged: (v) => _changenickName(v),
                                onTap: () {
                                  // 性别数据源
                                  List<String> genderList = ['男', '女'];
                                  Pickers.showSinglePicker(context,
                                      data: genderList,
                                      pickerStyle: PickerStyle(
                                          commitButton: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.only(
                                            left: 12, right: 22),
                                        child: Text('确定',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0)),
                                      )), onConfirm: (pickedData, index) {
                                    print("pickedData:$pickedData");
                                    if (pickedData == "男") {
                                      sex = 0;
                                    } else if (pickedData == "女") {
                                      sex = 1;
                                    }
                                    log.i("sex:$sex");
                                    setState(() {
                                      _sexController.text = pickedData;
                                      userInfoData?.sex = sex;
                                    });
                                  });
                                },
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
                                keyboardType: TextInputType.number,
                                controller: _heightController,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,// 只允许数字
                                ],
                                style: TextStyle(color: Colors.white),
                                onChanged: (v) => _changeHeight(v),
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
                                keyboardType: TextInputType.number,
                                controller: _weightController,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,// 只允许数字
                                ],
                                style: TextStyle(color: Colors.white),
                                onChanged: (v) => _changeWeight(v),
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
                                onChanged: (v) => _changeSign(v),
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
                                onChanged: (v) => _changeTeam(v),
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
                                onChanged: (v) => _changeFootballer(v),
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
                                controller: _positionController,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                onChanged: (v) => _changePos(v),
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
                                onChanged: (v) => _changeFeet(v),
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
                              onTap: () async {
                                if (_nickNameController.text.isEmpty) {
                                  ToastUtil.showSimpleCenterToast("昵称不能为空");
                                  return;
                                }
                                if (_ageController.text.isEmpty) {
                                  ToastUtil.showSimpleCenterToast("年龄不能为空");
                                  return;
                                }
                                if (_sexController.text.isEmpty) {
                                  ToastUtil.showSimpleCenterToast("性别不能为空");
                                  return;
                                }
                                if (_heightController.text.isEmpty) {
                                  ToastUtil.showSimpleCenterToast("身高不能为空");
                                  return;
                                }
                                if (_weightController.text.isEmpty) {
                                  ToastUtil.showSimpleCenterToast("体重不能为空");
                                  return;
                                }
                                // if (_signController.text.isEmpty) {
                                //   ToastUtil.showSimpleCenterToast("个签不能为空");
                                //   return;
                                // }
                                if (_teamController.text.isEmpty) {
                                  ToastUtil.showSimpleCenterToast("喜爱球队不能为空");
                                  return;
                                }
                                if (_footballerController.text.isEmpty) {
                                  ToastUtil.showSimpleCenterToast("喜爱球员不能为空");
                                  return;
                                }
                                if (_positionController.text.isEmpty) {
                                  ToastUtil.showSimpleCenterToast("站位不能为空");
                                  return;
                                }
                                if (_dominantFootController.text.isEmpty) {
                                  ToastUtil.showSimpleCenterToast("惯用脚不能为空");
                                  return;
                                }
                                userInfoData?.avatar = "";
                                log.i("userInfoData:$userInfoData");
                                try {
                                  var res = await logic?.editUserInfo(userInfoData!);
                                  log.i("editUserInfo:$res");
                                  if (res["status"] == true) {
                                    log.i("editUserInfo成功");
                                    Get.to(() => DeviceBinding(),
                                        transition: Transition.rightToLeft);
                                  } else {
                                    ToastUtil.showSimpleCenterToast("提交用户信息失败，请稍后重试");
                                  }
                                } on DioException catch (e) {
                                  log.e("editUserInfo失败：${e.response}");
                                  ToastUtil.showSimpleCenterToast("提交用户信息失败，请稍后重试");
                                }
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
