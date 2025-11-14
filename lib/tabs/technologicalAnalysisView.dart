import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../ui/technologicalAnalysis/trendAnalysis/easyAnalysis/easyAnalysisView.dart';
import '../ui/technologicalAnalysis/trendAnalysis/trendAnalysisView.dart';
import '../utils/log.dart';
import '../utils/style/textStyle.dart';

class TechnologicalAnalysisView extends StatefulWidget {
  const TechnologicalAnalysisView({super.key});

  @override
  State<TechnologicalAnalysisView> createState() =>
      _TechnologicalAnalysisViewState();
}

class _TechnologicalAnalysisViewState extends State<TechnologicalAnalysisView> {
  TextEditingController _seoController = TextEditingController();
  FocusNode _seoFocusNode = FocusNode();
  int _topItemIndex = 0; // 当前最顶部的项索引
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  void _handleScrollNotification(ScrollNotification notification) {
    final scrollOffset = notification.metrics.pixels;
    final itemHeight = 220.0;

    // 计算当前最顶部的项索引
    final newTopIndex = (scrollOffset / itemHeight).round();

    ///TODO 10是有多少个子项，目前写死，此处应该根据子项数量而变化
    if (newTopIndex != _topItemIndex && newTopIndex >= 0 && newTopIndex < 10) {
      setState(() {
        _topItemIndex = newTopIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      body: Container(
        padding: EdgeInsets.fromLTRB(12, 50, 12, 0),
        height: Get.height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 126,
                  padding: EdgeInsets.fromLTRB(45, 11, 20, 11),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'images/bg_jishu.png',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Text(
                    "技术分析",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(16, 16, 16, 1),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => TrendAnalysisView(),
                        transition: Transition.rightToLeft);
                  },
                  child: Image.asset(
                    'images/next2.png',
                    width: 27,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 254,
                  margin: EdgeInsets.fromLTRB(0, 20, 1, 18),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(48, 48, 48, 1),
                      borderRadius: BorderRadius.circular(18.5)),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: _seoController,
                    focusNode: _seoFocusNode,
                    cursorColor: Color.fromRGBO(226, 6, 19, 1),
                    style: TextStyle(color: Colors.white, fontSize: 14),
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
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification notification) {
                  if (notification is ScrollUpdateNotification ||
                      notification is ScrollEndNotification) {
                    _handleScrollNotification(notification);
                  }
                  return false;
                },
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    final isTopItem = index == _topItemIndex;
                    final isOdd = index % 2 == 1; // 奇数列

                    return Container(
                      height: 220,
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                isOdd ? 29 : 16, 23, isOdd ? 12 : 29, 24),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(isOdd
                                    ? 'images/bg_qiuchang2.png'
                                    : 'images/bg_qiuchang1.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: isOdd
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    if (!isOdd)
                                      Container(
                                        width: 91,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/bg_juxin1.png'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        child: Center(
                                            child: Text("虹口足球场",
                                                style: AllTextStyle.f12Black)),
                                      ),
                                    if (!isOdd) SizedBox(width: 13),
                                    Text("2025.05.12",
                                        style: AllTextStyle.f8White),
                                    if (isOdd) SizedBox(width: 13),
                                    if (isOdd)
                                      Container(
                                        width: 91,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/bg_juxin1.png'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        child: Center(
                                            child: Text("虹口足球场",
                                                style: AllTextStyle.f12Black)),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 17),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    if (!isOdd)
                                      Stack(
                                        children: [
                                          Image.asset("images/video_l.png",
                                              width: 172),
                                          Positioned(
                                            child: Image.asset(
                                              "images/play.png",
                                              width: 21,
                                            ),
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                          )
                                        ],
                                      ),
                                    Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            log.i("index:$index");
                                            Get.to(() => EasyAnalysisView(),
                                                transition: Transition.rightToLeft);
                                          },
                                          child: Container(
                                            width: 91,
                                            height: 28,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'images/bg_juxin.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            child: Center(
                                                child: Text("简单分析",
                                                    style:
                                                        AllTextStyle.f10White)),
                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            width: 91,
                                            height: 28,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'images/bg_juxin.png'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            child: Center(
                                                child: Text("分析报告",
                                                    style:
                                                        AllTextStyle.f10White)),
                                          ),
                                        )
                                      ],
                                    ),
                                    if (isOdd)
                                      Stack(
                                        children: [
                                          Image.asset("images/video.png",
                                              width: 172),
                                          Positioned(
                                            child: Image.asset(
                                                "images/play.png",
                                                width: 21),
                                            left: 0,
                                            right: 0,
                                            top: 0,
                                            bottom: 0,
                                          )
                                        ],
                                      ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          // 只有非顶部项才显示黑幕
                          if (!isTopItem)
                            IgnorePointer(
                              // 黑幕忽略所有点击，事件传递到底层按钮
                              ignoring: true,
                              child: Container(
                                height: 220,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                  itemCount: 10,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
