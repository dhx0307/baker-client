import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class GameDataView extends StatefulWidget {
  const GameDataView({super.key});

  @override
  State<GameDataView> createState() => _GameDataViewState();
}

class _GameDataViewState extends State<GameDataView> {
  TextEditingController _seoController = TextEditingController();
  FocusNode _seoFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _seoFocusNode.unfocus();
      },
      child: Scaffold(
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
          padding: EdgeInsets.fromLTRB(12, 20, 12, 0),
          height: Get.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "* 你 已 进 行 了 3 场 比 赛",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(48, 48, 48, 1),
                    borderRadius: BorderRadius.circular(18.5)),
                child:
                TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _seoController,
                    focusNode: _seoFocusNode,
                    cursorColor: Color.fromRGBO(226, 6, 19, 1),
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    // onChanged: (v) => _changenickName(v),
                    decoration: InputDecoration(
                      prefixIcon: GestureDetector(
                        onTap: () {
                          _seoFocusNode.unfocus();
                          print(_seoController.text);
                        },
                        child: Container(
                          width: 30, // 与输入框高度一致
                          alignment: Alignment.centerLeft, // 内容居左
                          padding: EdgeInsets.only(left: 10, right: 8), // 调整边距
                          child: SizedBox(
                            width: 14,
                            height: 14,
                            child: Image.asset(
                              "images/sousuox.png",
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      counterText: '',
                      isDense: true,
                      // 减少默认内边距，帮助垂直居中
                      filled: true,
                      // 必须设置为true才能显示背景色
                      fillColor: Colors.transparent,
                      // 背景色（透明或你需要的颜色）
                      // 圆角边框设置
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.5),
                        borderSide: BorderSide.none, // 无边框线（如果需要边框线可以设置颜色）
                      ),
                      // 禁用状态样式
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.5),
                        borderSide: BorderSide.none,
                      ),
                      // 聚焦状态样式
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.5),
                        borderSide: BorderSide(
                          color: Color.fromRGBO(226, 6, 19, 1),
                          width: 1.0,
                        ),
                      ),
                      // 内容内边距
                      contentPadding: EdgeInsets.only(
                        top: 0, // 关键：顶部和底部 padding 必须为 0
                        bottom: 0, // 关键：通过 height 和 alignment 控制居中
                        left: 0, // 水平方向由 prefixIcon 的 padding 控制
                        right: 16,
                      ),
                      constraints: BoxConstraints(
                        minHeight: 36, // 固定高度为 36
                        maxHeight: 36, // 固定高度为 36
                      ),
                    )),
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          height: 164,
                          padding: EdgeInsets.fromLTRB(14, 16, 14, 16),
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/bg_gameData.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/bg_game1.png",
                                    fit: BoxFit.contain,
                                    width: 93,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        'images/qingtian.png',
                                        fit: BoxFit.contain,
                                        width: 9,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "05/13",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "虹口足球场",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset(
                                        'images/shijian.png',
                                        fit: BoxFit.contain,
                                        width: 9,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "00:56:12",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "站位：",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "LB",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "惯用脚：",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "右脚",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 192,
                                    height: 78,
                                    padding: EdgeInsets.fromLTRB(14, 10, 14, 8),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage('images/bg_data.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "射门：",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "70",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 34,
                                                ),
                                                Text(
                                                  "短传：",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "70",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              height: 1,
                                              thickness: 1,
                                              color:
                                                  Color.fromRGBO(16, 16, 16, 1),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "长传：",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "70",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 34,
                                                ),
                                                Text(
                                                  "跑动：",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "70",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              height: 1,
                                              thickness: 1,
                                              color:
                                                  Color.fromRGBO(16, 16, 16, 1),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "触球：",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(
                                                      16, 16, 16, 1),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "70",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(
                                                      16, 16, 16, 1),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              width: 34,
                                            ),
                                            Text(
                                              "卡路里消耗：",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(
                                                      16, 16, 16, 1),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "70",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(
                                                      16, 16, 16, 1),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text("92.1",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                ],
                              ))
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          height: 164,
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.fromLTRB(14, 16, 14, 16),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/bg_gameData.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 93,
                                    height: 32,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/bg_amountGame.png'),
                                          fit: BoxFit.contain,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    child: Center(
                                      child: Text(
                                        "第$index场比赛",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            fontWeight: FontWeight.w800),
                                      ),
                                    ),
                                    // child: ,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        'images/qingtian.png',
                                        fit: BoxFit.contain,
                                        width: 9,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "05/13",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "虹口足球场",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Image.asset(
                                        'images/shijian.png',
                                        fit: BoxFit.contain,
                                        width: 9,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "00:56:12",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "站位：",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "LB",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "惯用脚：",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "右脚",
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 11,
                              ),
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 192,
                                    height: 78,
                                    padding: EdgeInsets.fromLTRB(14, 10, 14, 8),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image:
                                              AssetImage('images/bg_data.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(16))),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "射门：",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "70",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 34,
                                                ),
                                                Text(
                                                  "短传：",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "70",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              height: 1,
                                              thickness: 1,
                                              color:
                                                  Color.fromRGBO(16, 16, 16, 1),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "长传：",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "70",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                SizedBox(
                                                  width: 34,
                                                ),
                                                Text(
                                                  "跑动：",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "70",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color: Color.fromRGBO(
                                                          16, 16, 16, 1),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              height: 1,
                                              thickness: 1,
                                              color:
                                                  Color.fromRGBO(16, 16, 16, 1),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "触球：",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(
                                                      16, 16, 16, 1),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "70",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(
                                                      16, 16, 16, 1),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              width: 34,
                                            ),
                                            Text(
                                              "卡路里消耗：",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(
                                                      16, 16, 16, 1),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              "70",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Color.fromRGBO(
                                                      16, 16, 16, 1),
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text("92.1",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white)),
                                ],
                              ))
                            ],
                          ),
                        );
                      }
                    },
                    separatorBuilder: (context, index) => Divider(
                        height: 0.5, color: Color.fromRGBO(16, 16, 16, 0.5)),
                    itemCount: 3),
              )
            ],
          ),
        ),
      ),
    );
  }
}
