import 'package:bakersoccer/ui/technologicalAnalysis/trendAnalysis/pageViewUtilLogic.dart';
import 'package:bakersoccer/ui/technologicalAnalysis/trendAnalysis/touchBallRotationChart/touchBallRotationChartView.dart';
import 'package:bakersoccer/ui/technologicalAnalysis/trendAnalysis/trendAnalysisView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/log.dart';

class PageViewUtilView extends StatefulWidget {
  const PageViewUtilView({super.key});

  @override
  State<PageViewUtilView> createState() => _PageViewUtilViewState();
}

class _PageViewUtilViewState extends State<PageViewUtilView> {
  // 控制PageView的控制器
  late final PageController _pageController;
  int _currentPage = 0;
  late PageViewUtilLogic logic;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0);
    logic = Get.put(PageViewUtilLogic());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(16, 16, 16, 1),
        body: Obx(
          () => PageView(
            controller: _pageController,
            // 关键修改：拖拽时禁用 PageView 滑动
            physics: logic.isPageViewScrollable.value
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;

                /// TODO 当_currentPage发生变化时才真正切换到此页面
                log.i("_currentPage:$_currentPage");
              });
            },
            children: [TrendAnalysisView(), TouchBallRotationChartView()],
          ),
        ));
  }
}
