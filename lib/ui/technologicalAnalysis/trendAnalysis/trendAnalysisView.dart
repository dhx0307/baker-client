import 'dart:async';

import 'package:bakersoccer/ui/technologicalAnalysis/trendAnalysis/rightRunningPacePageView/rightRunningPacePageView.dart';
import 'package:bakersoccer/ui/technologicalAnalysis/trendAnalysis/touchBallRotationChart/touchBallRotationChartView.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/stackImage/stackImage.dart';
import '../../../utils/log.dart';
import '../../../utils/style/textStyle.dart';
import 'leftRunningPacePageView/leftRunningPacePageView.dart';
import 'package:rotation/rotation.dart';

// 添加PageStorageKey来保持PageView状态
final _pageStorageKey = PageStorageKey('trendAnalysisPageView');

class TrendAnalysisView extends StatefulWidget {
  const TrendAnalysisView({super.key});

  @override
  State<TrendAnalysisView> createState() => _TrendAnalysisViewState();
}

class _TrendAnalysisViewState extends State<TrendAnalysisView> {
  final List<String> items = [
    '单项能力趋势',
    '综合赛场趋势',
  ];
  String? selectedValue = '单项能力趋势';
  bool isDropdownOpen = false;

  // 保存初始图片URL，用于恢复左侧图片
  final Map<int, String?> initialImageUrls = {};

  // 图片数据列表
  List<StackImage> images = [
    StackImage(
      id: 1,
      title: '触球趋势',
      imageUrl: 'images/rectangle1_a.png',
    ),
    StackImage(
      id: 2,
      title: '传球趋势',
      imageUrl: 'images/rectangle2_a.png',
    ),
    StackImage(
      id: 3,
      title: '射门趋势',
      imageUrl: 'images/rectangle3_a.png',
    ),
  ];

  // 当前拖拽的索引
  int? _draggingIndex;

  // 拖拽偏移量
  Offset _dragOffset = Offset.zero;

  // 拖拽开始的位置
  double _dragStartPosition = 0.0;

  // 长按计时器
  Timer? _longPressTimer;

  // 当前最右边的图片名称
  String? currentRightMostImage = "射门趋势";

  // 跟踪选中的点
  FlSpot? _selectedSpot;
  OverlayEntry? _tooltipOverlayEntry;
  final GlobalKey _chartKey1 = GlobalKey();
  final GlobalKey _chartKey2 = GlobalKey();
  final GlobalKey _chartKey3 = GlobalKey();
  final GlobalKey _chartKey4 = GlobalKey();

  // 控制PageView的控制器
  late PageController _pageController;

  // 当前页面索引
  int _currentPage = 0;

  // 动画因子：左侧页面时为1.0，右侧页面时为0.0
  // 新增：标记是否已添加监听器（防止重复添加）
  bool _isListenerAdded = false;

  // 页面可见进度：0=完全不可见，1=完全可见（核心修改）
  double _leftVisibleProgress = 1.0; // 左侧初始完全可见
  double _rightVisibleProgress = 0.0; // 右侧初始完全不可见
  // 旋转
  RotatorFlipState _flipState = RotatorFlipState.showFirst;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 初始化PageController，使用PageStorage恢复状态
    _pageController = PageController(initialPage: 0);
    // 保存初始图片URL，用于后续恢复左侧图片
    for (var image in images) {
      initialImageUrls[image.id!] = image.imageUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 仅在首次构建时添加监听（确保 MediaQuery 能获取正确宽度）
    if (!_isListenerAdded) {
      _pageController.addListener(_updateVisibleProgress);
      _isListenerAdded = true;
    }
  }

  @override
  void dispose() {
    _hideTooltip(); // 确保图表的悬浮窗被清除
    _selectedSpot = null; // 确保图表的选中状态被清除
    _longPressTimer?.cancel();
    _pageController.removeListener(_updateVisibleProgress);
    _pageController.dispose();
    super.dispose();
  }

  // 处理页面滚动事件
  void _updateVisibleProgress() {
    final pageWidth = MediaQuery.of(context).size.width;
    if (pageWidth == 0) return;

    final scrollOffset = _pageController.offset / pageWidth;
    // 打印进度，验证滑动时是否连续变化（可选，调试用）
    // log.i("scrollOffset: $scrollOffset（最大应接近1.0）");

    setState(() {
      _leftVisibleProgress = (1.0 - scrollOffset).clamp(0.0, 1.0);
      _rightVisibleProgress = scrollOffset.clamp(0.0, 1.0);
      _currentPage = _pageController.page?.round() ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      body: Container(
        padding: EdgeInsets.fromLTRB(12, 50, 12, 112),
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
                      image: AssetImage('images/bg_jishu.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: Text(
                    "趋势分析",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(16, 16, 16, 1),
                        fontWeight: FontWeight.w600),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _hideTooltip(); // 确保图表的悬浮窗被清除
                    setState(() {
                      _selectedSpot = null; // 确保图表的选中状态被清除
                    });
                    Get.to(TouchBallRotationChartView());
                  },
                  child: Image.asset(
                    'images/next2.png',
                    width: 27,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 19,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 120,
                  height: 36,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                          log.i("selectedValue:$selectedValue");
                          _selectedSpot = null; // 确保图表的选中状态被清除
                          _hideTooltip(); // 切换时确保图表的悬浮窗被清除
                        });
                        // 如果切换回单项能力趋势，确保PageView状态正确
                        if (value == '单项能力趋势') {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            // 确保UI重建完成后更新状态
                            _updateVisibleProgress();
                          });
                        }
                      },
                      onMenuStateChange: (bool isOpen) {
                        setState(() {
                          isDropdownOpen = isOpen;
                        });
                      },
                      buttonStyleData: ButtonStyleData(
                        height: 36,
                        width: 118,
                        padding: const EdgeInsets.only(left: 13, right: 13),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromRGBO(48, 48, 48, 1),
                        ),
                      ),
                      iconStyleData: IconStyleData(
                        icon: Image.asset(
                          isDropdownOpen
                              ? 'images/s_triangle.png'
                              : 'images/x_triangle.png',
                          width: 12,
                          fit: BoxFit.contain,
                        ),
                        iconSize: 12,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        width: 118,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color.fromRGBO(60, 60, 60, 1),
                        ),
                        offset: const Offset(0, -5),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.symmetric(horizontal: 21)),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            if (selectedValue == "单项能力趋势")
              _buildSingleAbilityContent()
            else
              Container(
                width: Get.width,
                height: 262,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(34, 34, 34, 1),
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Container(
                  width: Get.width,
                  height: 262,
                  padding: EdgeInsets.fromLTRB(13, 9, 9, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 16, // 保持相同的宽度
                            height: 16, // 保持相同的高度
                            color: Colors.transparent, // 透明背景
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(13, 0, 0, 5),
                            child: Text(
                              "评分",
                              style: AllTextStyle.f8White,
                            ),
                          )
                        ],
                      ),
                      Container(
                        key: _chartKey4,
                        height: 204,
                        width: double.infinity, // 占满父组件宽度,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: LineChart(LineChartData(
                                    minX: 0,
                                    maxX: 52,
                                    minY: 0,
                                    maxY: 108,
                                    // 配置网格线
                                    gridData: FlGridData(
                                      show: true,
                                      // X轴网格线配置
                                      horizontalInterval: 1, // Y轴不显示网格线，设置为1但不显示
                                      getDrawingHorizontalLine: (value) {
                                        // Y轴不显示网格线
                                        return FlLine(
                                          color: Colors.transparent,
                                          strokeWidth: 0,
                                        );
                                      },
                                      // X轴网格线配置
                                      verticalInterval: 5, // 每5格显示一条虚线
                                      getDrawingVerticalLine: (value) {
                                        // 只在X轴每5格显示虚线
                                        return FlLine(
                                          color: Color.fromRGBO(90, 90, 90, 1), // 虚线颜色
                                          strokeWidth: 0.5,
                                          dashArray: [2, 0], // 虚线样式 [线段长度, 间隔长度]
                                        );
                                      },
                                    ),
                                    // 配置坐标轴标签
                                    titlesData: FlTitlesData(
                                      // X轴配置（底部）
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 5,
                                          getTitlesWidget: (value, meta) {
                                            // X轴只在value>0时显示标签，避免与Y轴0点重复
                                            if (value == 0) {
                                              return SizedBox
                                                  .shrink(); // 不显示X轴的0
                                            }
                                            // 只显示到50的刻度
                                            if (value > 50) {
                                              return SizedBox.shrink();
                                            }
                                            return Padding(
                                              padding: EdgeInsets.only(top: 6),
                                              child: Text(
                                                '${value.toInt()}',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      // Y轴配置（左侧）
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                            showTitles: true,
                                            // 设置Y轴刻度间隔
                                            interval: 20, // 每20个单位显示一个刻度
                                            getTitlesWidget: (value, meta) {
                                              // 只显示到35的刻度
                                              if (value > 100) {
                                                return SizedBox.shrink();
                                              }
                                              return Text(
                                                '${value.toInt()}',
                                                style: TextStyle(
                                                    fontSize: 10, // 字体大小10
                                                    color: Colors.white),
                                              );
                                            }),
                                      ),
                                      // 隐藏顶部和右侧的轴
                                      topTitles: AxisTitles(
                                          sideTitles:
                                          SideTitles(showTitles: false)),
                                      rightTitles: AxisTitles(
                                          sideTitles:
                                          SideTitles(showTitles: false)),
                                    ),
                                    // 配置轴线
                                    borderData: FlBorderData(
                                      show: true,
                                      border: Border(
                                        bottom: BorderSide(color: Colors.white),
                                        // X轴线
                                        left: BorderSide(color: Colors.white),
                                        // Y轴线
                                        top: BorderSide.none,
                                        // 隐藏顶部边框
                                        right: BorderSide.none, // 隐藏右侧边框
                                      ),
                                    ),
                                    lineTouchData: LineTouchData(
                                      enabled: true,
                                      handleBuiltInTouches: false, // 隐藏默认触摸指示器
                                      touchCallback: (event, response) {
                                        if (event is FlTapUpEvent && response != null && response.lineBarSpots != null) {
                                          // 获取第一个触摸到的点
                                          final touchedSpot = response.lineBarSpots!.first;

                                          setState(() {
                                            // 直接使用触摸到的点坐标
                                            _selectedSpot = FlSpot(touchedSpot.x, touchedSpot.y);
                                          });
                                          _showTooltip(touchedSpot,_chartKey4);

                                          log.i("选中的点: ${_selectedSpot}");
                                        } else {
                                          // 点击空白处隐藏悬浮窗和选中点
                                          setState(() {
                                            _selectedSpot = null; // 确保选中状态被清除
                                          });
                                          _hideTooltip();
                                        }
                                      },
                                    ),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: [
                                          FlSpot(0, 40),
                                          FlSpot(5, 50),
                                          FlSpot(10, 60),
                                          FlSpot(15, 65),
                                          FlSpot(20, 50),
                                          FlSpot(30, 70),
                                          FlSpot(40, 75),
                                          FlSpot(50, 80),
                                        ],
                                        isCurved: true,
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        barWidth: 2,
                                        // 白色数据点
                                        dotData: FlDotData(
                                            show: true,
                                            getDotPainter:
                                                (spot, percent, barData, index) {
                                              bool isSelected = _selectedSpot != null &&
                                                  _selectedSpot!.x == spot.x &&
                                                  _selectedSpot!.y == spot.y;
                                              if (isSelected) {
                                                // 选中的点：宽11高11的圆形，白色透明度0.5
                                                return _SelectedDotPainter(centerDotColor: Color.fromRGBO(255, 255, 255, 1));
                                              } else {
                                                return FlDotCirclePainter(
                                                  radius: 2.5,
                                                  color: Color.fromRGBO(255, 255, 255, 1),
                                                  strokeWidth: 1,
                                                  strokeColor:
                                                  Color.fromRGBO(255, 255, 255, 1),
                                                );
                                              }

                                            }

                                        ),
                                        // 添加阴影填充
                                        belowBarData: BarAreaData(
                                          show: true,
                                          gradient: LinearGradient(
                                            colors: [
                                              Color.fromRGBO(218, 56, 66, 1),
                                              // 上方颜色
                                              Color.fromRGBO(216, 216, 216, 1),
                                              // 下方颜色
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                        ),
                                      )
                                    ]))),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 17),
                              child: Text(
                                "场次",
                                style: AllTextStyle.f8White,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleAbilityContent() {
    return Expanded(
        child: Container(
          // height: 520,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                  width: Get.width,
                  height: 262,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(34, 34, 34, 1),
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: RotatorFlip(
                    duration: const Duration(milliseconds: 500),
                    flipState: _flipState,
                    firstChild: Container(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 18),
                      child: Column(
                        children: [
                          Container(
                            height: 193,
                            child: _buildImageStack(),
                          ),
                          const SizedBox(height: 18),
                          Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("images/rectangle1_.png",
                                          width: 24, fit: BoxFit.contain),
                                      const SizedBox(width: 6),
                                      Text("触球趋势", style: AllTextStyle.f10White)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset("images/rectangle2_.png",
                                          width: 24, fit: BoxFit.contain),
                                      const SizedBox(width: 6),
                                      Text("传球趋势", style: AllTextStyle.f10White)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset("images/rectangle3_.png",
                                          width: 24, fit: BoxFit.contain),
                                      const SizedBox(width: 6),
                                      Text("射门趋势", style: AllTextStyle.f10White)
                                    ],
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                    secondChild: _buildChartWidget(),
                  )),
              SizedBox(
                height: 19,
              ),
              Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 175,
                        // height: 242,
                        // padding: EdgeInsets.fromLTRB(6, 7, 14, 18),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(34, 34, 34, 1),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: Stack(
                          children: [
                            // 页面内容区域
                            // 使用PageStorage保存PageView状态
                            PageStorage(
                              bucket: PageStorageBucket(),
                              child: PageView(
                                key: _pageStorageKey,
                                // 使用全局key来保持状态
                                controller: _pageController,
                                physics: const BouncingScrollPhysics(),
                                onPageChanged: (index) {
                                  setState(() {
                                    _currentPage = index;

                                    /// TODO 当_currentPage发生变化时才真正切换到此页面
                                    log.i("_currentPage:$_currentPage");
                                  });
                                },
                                children: [
                                  LeftRunningPacePageView(
                                      visibleProgress: _leftVisibleProgress),
                                  RightRunningPacePageView(
                                      visibleProgress: _rightVisibleProgress),
                                ],
                              ),
                            ),
                            // 页面指示器，使用Positioned控制位置
                            Positioned(
                              right: 12, // 距离右边12
                              bottom: 18, // 距离下边18
                              child: _buildPageIndicator(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 110,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(66, 55, 47, 1),
                                    borderRadius: BorderRadius.all(Radius.circular(14.0)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "技",
                                            style: AllTextStyle.f10Orange,
                                          ),
                                          Text(
                                            "术",
                                            style: AllTextStyle.f10Orange,
                                          ),
                                          Text(
                                            "特",
                                            style: AllTextStyle.f10Orange,
                                          ),
                                          Text(
                                            "点",
                                            style: AllTextStyle.f10Orange,
                                          ),
                                          Text(
                                            "评",
                                            style: AllTextStyle.f10Orange,
                                          ),
                                          Text(
                                            "价",
                                            style: AllTextStyle.f10Orange,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                  barrierDismissible: true,
                                                  // 点击外部可关闭
                                                  context: context,
                                                  builder: (BuildContext context) {
                                                    return _buildShowDiaog(
                                                        title: "技术特点评价",
                                                        content: "技术特点评价技术特"
                                                            "技术特点评价技术特点评价技术特点评价技术特点评价"
                                                            "技术特点评价技术特点评价技术特点评价技术特点评价"
                                                            "技术特点评价技术特点评价技术特点评价点评技术特点评价技术特点评价技术特点评价技术特点评价"
                                                            "技术特点评价技术特点评价技术特点价技术特点评价技术特点评价技术特点评价技术特点评价");
                                                  });
                                            },
                                            child: Container(
                                              // width: 124,
                                              height: 96,
                                              padding: EdgeInsets.fromLTRB(9, 9, 9, 9),
                                              decoration: BoxDecoration(
                                                color: Color.fromRGBO(210, 142, 98, 0.2),
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(12.0)),
                                              ),
                                              child: Text(
                                                "技术特点技术特点技术特点技术特点技术特点技术特点技术特点技术特点技术特点技术特点技术特点技术特点",
                                                style: AllTextStyle.f10White,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 5,
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 120,
                                child: Stack(
                                  children: [
                                    Image.asset('images/bg_position.png',
                                        height: 120, fit: BoxFit.contain),
                                    Positioned.fill(
                                      child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              barrierDismissible: true, // 点击外部可关闭
                                              context: context,
                                              builder: (BuildContext context) {
                                                return _buildShowDiaog(
                                                    title: "位置特点评价",
                                                    content: "位置特点评价位置特点评价位置特点评价位置特点评价"
                                                        "位置特点评价位置特点评价位置特点评价"
                                                        "位置特点评价位置特点评价位置特点评价位置特点评价位置特点评价位置特点评价位置特点评价"
                                                        "位置特点评价位置特点评价位置特点评价位置特点评价位置特点评价位置特点评价位置特点评价位置特点评价位置特点评价");
                                              });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.fromLTRB(20, 18, 28, 27),
                                          child: LayoutBuilder(
                                            builder: (context, constraints) {
                                              /// TODO 文本需要动态传入
                                              final text =
                                                  "位评价特点评价位置特特点评价位置特特点评价位置特点评价位点评价位点评价位点评价位点评价位";

                                              // 创建一个TextPainter来计算文本布局
                                              final textPainter = TextPainter(
                                                text: TextSpan(
                                                  text: text,
                                                  style: AllTextStyle.f10White,
                                                ),
                                                maxLines: 6,
                                                textDirection: TextDirection.ltr,
                                              );
                                              textPainter.layout(
                                                  maxWidth: constraints.maxWidth);

                                              // 检查文本是否超过3行（约27个字）
                                              if (textPainter.didExceedMaxLines ||
                                                  text.length >= 27) {
                                                // 分割文本：前3行和后几行
                                                final firstPart = _getTextForLines(
                                                    text,
                                                    3,
                                                    constraints.maxWidth,
                                                    AllTextStyle.f10White);
                                                final remainingText =
                                                text.substring(firstPart.length);

                                                return RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: firstPart,
                                                        style: AllTextStyle.f10White,
                                                      ),
                                                      WidgetSpan(
                                                        child: Container(
                                                          padding:
                                                          EdgeInsets.only(left: 40),
                                                          // 从第4行开始加左padding
                                                          child: Text(
                                                            remainingText,
                                                            style: AllTextStyle.f10White,
                                                            maxLines: 2,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis,
                                                );
                                              } else {
                                                // 文本不超过3行，正常显示
                                                return Text(
                                                  text,
                                                  style: AllTextStyle.f10White,
                                                  overflow: TextOverflow.ellipsis,
                                                  maxLines: 5,
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      bottom: 3,
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: Image.asset("images/ai.png",
                                              width: 40, fit: BoxFit.contain),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ))
                    ],
                  ))
            ],
          ),
        ));
  }

  // 辅助函数：获取指定行数的文本
  String _getTextForLines(
      String text, int lines, double maxWidth, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: lines,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: maxWidth);

    // 找到第lines行结束的位置
    final position = textPainter
        .getPositionForOffset(Offset(maxWidth, lines * style.fontSize! * 1.2));
    final endIndex =
        textPainter.getOffsetBefore(position.offset) ?? text.length;

    return text.substring(0, endIndex + 1).trim();
  }

  // 构建拖拽排序
  Widget _buildImageStack() {
    return Container(
      width: 190 + 45 * (images.length - 1),
      child: Stack(
        children: images.asMap().entries.map((entry) {
          int index = entry.key;
          StackImage image = entry.value;

          // 计算正常位置 - 每张图片向右偏移45px
          double normalPosition = index * 45.0;

          // 如果是正在拖拽的图片，使用拖拽偏移量
          bool isDragging = _draggingIndex == index;
          double currentPosition =
          isDragging ? _dragStartPosition + _dragOffset.dx : normalPosition;

          return Positioned(
            left: currentPosition,
            top: 0,
            child: Listener(
              onPointerDown: (PointerDownEvent event) {
                _startLongPressTimer(index, normalPosition);
              },
              onPointerUp: (PointerUpEvent event) {
                _cancelLongPress();
              },
              onPointerCancel: (PointerCancelEvent event) {
                _cancelLongPress();
              },
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onPanStart: (DragStartDetails details) {
                  // 只有在长按后才会进入拖拽模式
                  if (_draggingIndex == index) {
                    setState(() {
                      _dragStartPosition = normalPosition;
                      _dragOffset = Offset.zero;
                    });
                  }
                },
                onPanUpdate: (DragUpdateDetails details) {
                  if (_draggingIndex == index) {
                    setState(() {
                      _dragOffset += details.delta;
                    });

                    // 实时检查是否需要交换位置
                    _checkReorder(index);
                  }
                },
                onPanEnd: (DragEndDetails details) {
                  _handleDragEnd();
                },
                onPanCancel: () {
                  _handleDragEnd();
                },
                child: Container(
                  key: Key(image.id.toString()),
                  width: 190,
                  height: 193,
                  child: Stack(
                    children: [
                      // 图片
                      Image.asset(
                        image.imageUrl!,
                        width: 190,
                        height: 193,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Container(
                            color: Colors.grey[800],
                            child: Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey[400],
                                size: 40,
                              ),
                            ),
                          );
                        },
                      ),
                      // 拖拽时的半透明效果
                      // if (isDragging)
                      //   Container(
                      //     width: 190,
                      //     height: 193,
                      //     color: Colors.transparent,
                      //     child: const Center(
                      //       child: Icon(
                      //         Icons.open_with,
                      //         color: Colors.white,
                      //         size: 30,
                      //       ),
                      //     ),
                      //   ),
                      // // 长按提示
                      // if (!isDragging)
                      //   Container(
                      //     width: 190,
                      //     height: 193,
                      //     child: Center(
                      //       child: Text(
                      //         '长按拖拽',
                      //         style: TextStyle(
                      //           color: Colors.white.withOpacity(0.7),
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _startLongPressTimer(int index, double normalPosition) {
    _longPressTimer?.cancel();
    _longPressTimer = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _draggingIndex = index;
        _dragStartPosition = normalPosition;
        _dragOffset = Offset.zero;
      });
    });
  }

  void _cancelLongPress() {
    _longPressTimer?.cancel();
  }

  void _checkReorder(int draggedIndex) {
    if (_draggingIndex == null) return;

    // 计算当前拖拽位置对应的目标索引
    double currentPosition = _dragStartPosition + _dragOffset.dx;
    int targetIndex = (currentPosition / 45.0).round();
    targetIndex = targetIndex.clamp(0, images.length - 1);

    // 只有当索引确实改变时才进行重新排序
    if (targetIndex != draggedIndex) {
      _reorderItems(draggedIndex, targetIndex);
    }
    print("draggedIndex: $draggedIndex, currentPosition: $currentPosition, targetIndex: $targetIndex");
  }

  void _reorderItems(int fromIndex, int toIndex) {
    setState(() {
      final item = images.removeAt(fromIndex);
      images.insert(toIndex, item);

      // 更新拖拽索引为新的位置
      _draggingIndex = toIndex;
      _dragStartPosition = toIndex * 45.0;
      _dragOffset = Offset.zero;
    });
  }

  void _handleDragEnd() {
    // 打印排序后的images内容
    _printImagesOrder();
    // 1. 拖拽完成后，获取最右侧图片（列表最后一位）并修改其imageUrl
    if (images.isNotEmpty) {
      // 防止列表为空时报错
      // 恢复左侧图片为初始状态
      for (int i = 0; i < images.length - 1; i++) {
        images[i].imageUrl = initialImageUrls[images[i].id];
      }
      switch (currentRightMostImage) {
        case "触球趋势":
          images.last.imageUrl = 'images/rectangle1.png';
          break;
        case "传球趋势":
          images.last.imageUrl = 'images/rectangle2.png';
          break;
        case "射门趋势":
          images.last.imageUrl = 'images/rectangle3.png';
          break;
        default:
        // 默认情况不修改
          break;
      }
    }
    // 拖拽完成后开始旋转
    _flipState = RotatorFlipState.showSecond;

    setState(() {
      _draggingIndex = null;
      _dragOffset = Offset.zero;
    });
  }

  void _printImagesOrder() {
    print("=== 拖拽完成，当前图片顺序 ===");
    for (int i = 0; i < images.length; i++) {
      print("位置 $i: ${images[i].title} (ID: ${images[i].id})");
      // 动态获取最右侧图片标题（避免硬编码索引）
      if (images.isNotEmpty) {
        currentRightMostImage = images.last.title;
        log.i("currentRightMostImage:$currentRightMostImage");
      }
    }
    // 使用log.i记录更详细的信息
    // log.i("图片排序完成，当前顺序: ${images.map((img) => '${img.title}(${img.id})').join(' -> ')}");
  }

  // 页面指示器
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (index) {
        return Container(
          width: 12,
          height: 6,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: _currentPage == index
                ? const Color.fromRGBO(255, 204, 141, 1) // 当前页指示器颜色
                : const Color.fromRGBO(48, 48, 48, 1), // 默认指示器颜色
          ),
        );
      }),
    );
  }

  // 旋转图表
  Widget _buildChartWidget() {
    if (currentRightMostImage == "射门趋势") {
      return Container(
        width: Get.width,
        height: 262,
        padding: EdgeInsets.fromLTRB(13, 9, 9, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _flipState = RotatorFlipState.showFirst;
                      // 切换页面时隐藏悬浮窗
                      _hideTooltip();
                      setState(() {
                        _selectedSpot = null; // 确保选中状态被清除
                      });
                    });
                  },
                  child: Image.asset(
                    "images/tuceng.png",
                    width: 16,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(13, 0, 0, 5),
                  child: Text(
                    "次数",
                    style: AllTextStyle.f8White,
                  ),
                )
              ],
            ),
            Container(
              key: _chartKey1, // 添加key用于获取位置
              height: 204,
              width: double.infinity, // 占满父组件宽度,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: LineChart(LineChartData(
                          minX: 0,
                          maxX: 52,
                          minY: 0,
                          maxY: 37,
                          // 配置网格线
                          gridData: FlGridData(
                            show: true,
                            // X轴网格线配置
                            horizontalInterval: 1, // Y轴不显示网格线，设置为1但不显示
                            getDrawingHorizontalLine: (value) {
                              // Y轴不显示网格线
                              return FlLine(
                                color: Colors.transparent,
                                strokeWidth: 0,
                              );
                            },
                            // X轴网格线配置
                            verticalInterval: 5, // 每5格显示一条虚线
                            getDrawingVerticalLine: (value) {
                              // 只在X轴每5格显示虚线
                              return FlLine(
                                color: Color.fromRGBO(90, 90, 90, 1), // 虚线颜色
                                strokeWidth: 0.5,
                                dashArray: [2, 0], // 虚线样式 [线段长度, 间隔长度]
                              );
                            },
                          ),
                          // 配置坐标轴标签
                          titlesData: FlTitlesData(
                            // X轴配置（底部）
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 5,
                                getTitlesWidget: (value, meta) {
                                  // X轴只在value>0时显示标签，避免与Y轴0点重复
                                  if (value == 0) {
                                    return SizedBox.shrink(); // 不显示X轴的0
                                  }
                                  // 只显示到50的刻度
                                  if (value > 50) {
                                    return SizedBox.shrink();
                                  }
                                  return Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Text(
                                      '${value.toInt()}',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Y轴配置（左侧）
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  // 设置Y轴刻度间隔
                                  interval: 5, // 每5个单位显示一个刻度
                                  getTitlesWidget: (value, meta) {
                                    // 只显示到35的刻度
                                    if (value > 35) {
                                      return SizedBox.shrink();
                                    }
                                    return Text(
                                      '${value.toInt()}',
                                      style: TextStyle(
                                          fontSize: 10, // 字体大小10
                                          color: Colors.white),
                                    );
                                  }),
                            ),
                            // 隐藏顶部和右侧的轴
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          // 配置轴线
                          borderData: FlBorderData(
                            show: true,
                            border: Border(
                              bottom: BorderSide(color: Colors.white), // X轴线
                              left: BorderSide(color: Colors.white), // Y轴线
                              top: BorderSide.none, // 隐藏顶部边框
                              right: BorderSide.none, // 隐藏右侧边框
                            ),
                          ),
                          lineTouchData: LineTouchData( // 添加触摸交互配置
                            enabled: true,
                            handleBuiltInTouches: false, // 隐藏默认触摸指示器
                            touchCallback: (event, response) {
                              if (event is FlTapUpEvent && response != null && response.lineBarSpots != null) {
                                // 获取第一个触摸到的点
                                final touchedSpot = response.lineBarSpots!.first;

                                setState(() {
                                  // 直接使用触摸到的点坐标
                                  _selectedSpot = FlSpot(touchedSpot.x, touchedSpot.y);
                                });
                                _showTooltip(touchedSpot,_chartKey1);

                                log.i("选中的点: ${_selectedSpot}");
                              } else {
                                // 点击空白处隐藏悬浮窗和选中点
                                setState(() {
                                  _selectedSpot = null; // 确保选中状态被清除
                                });
                                _hideTooltip();
                              }
                            },
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(0, 15),
                                FlSpot(5, 25),
                                FlSpot(10, 22),
                                FlSpot(15, 18),
                                FlSpot(20, 10),
                                FlSpot(30, 20),
                                FlSpot(40, 25),
                                FlSpot(50, 15),
                              ],
                              isCurved: true,
                              color: Color.fromRGBO(174, 49, 73, 1),
                              barWidth: 2,
                              // 白色数据点
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  // 检查是否是选中的点
                                  bool isSelected = _selectedSpot != null &&
                                      _selectedSpot!.x == spot.x &&
                                      _selectedSpot!.y == spot.y;

                                  if (isSelected) {
                                    // 选中的点：宽11高11的圆形，白色透明度0.5
                                    return _SelectedDotPainter(centerDotColor: Color.fromRGBO(164, 47, 69, 1));
                                  } else {
                                    // 普通点：保持原样
                                    return FlDotCirclePainter(
                                      radius: 2.5,
                                      color: Color.fromRGBO(164, 47, 69, 1),
                                      strokeWidth: 1,
                                      strokeColor: Color.fromRGBO(164, 47, 69, 1),
                                    );
                                  }
                                },
                              ),
                              // 添加阴影填充
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(222, 87, 87, 1), // 上方颜色
                                    Color.fromRGBO(69, 81, 116, 1), // 下方颜色
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            )
                          ]))),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 17),
                    child: Text(
                      "场次",
                      style: AllTextStyle.f8White,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else if (currentRightMostImage == "触球趋势") {
      return Container(
        width: Get.width,
        height: 262,
        padding: EdgeInsets.fromLTRB(13, 9, 9, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _flipState = RotatorFlipState.showFirst;
                    });
                    // 切换页面时隐藏悬浮窗
                    _hideTooltip();
                    setState(() {
                      _selectedSpot = null; // 确保选中状态被清除
                    });
                  },
                  child: Image.asset(
                    "images/tuceng.png",
                    width: 16,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(13, 0, 0, 5),
                  child: Text(
                    "次数",
                    style: AllTextStyle.f8White,
                  ),
                )
              ],
            ),
            Container(
              key: _chartKey2, // 添加key用于获取位置
              height: 204,
              width: double.infinity, // 占满父组件宽度,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Container(
                        child: LineChart(LineChartData(
                            minX: 0,
                            maxX: 52,
                            minY: 0,
                            maxY: 37,
                            // 配置网格线
                            gridData: FlGridData(
                              show: true,
                              // X轴网格线配置
                              horizontalInterval: 1, // Y轴不显示网格线，设置为1但不显示
                              getDrawingHorizontalLine: (value) {
                                // Y轴不显示网格线
                                return FlLine(
                                  color: Colors.transparent,
                                  strokeWidth: 0,
                                );
                              },
                              // X轴网格线配置
                              verticalInterval: 5, // 每5格显示一条虚线
                              getDrawingVerticalLine: (value) {
                                // 只在X轴每5格显示虚线
                                return FlLine(
                                  color: Color.fromRGBO(90, 90, 90, 1), // 虚线颜色
                                  strokeWidth: 0.5,
                                  dashArray: [2, 0], // 虚线样式 [线段长度, 间隔长度]
                                );
                              },
                            ),
                            // 配置坐标轴标签
                            titlesData: FlTitlesData(
                              // X轴配置（底部）
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 5,
                                  getTitlesWidget: (value, meta) {
                                    // X轴只在value>0时显示标签，避免与Y轴0点重复
                                    if (value == 0) {
                                      return SizedBox.shrink(); // 不显示X轴的0
                                    }
                                    // 只显示到50的刻度
                                    if (value > 50) {
                                      return SizedBox.shrink();
                                    }
                                    return Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Text(
                                        '${value.toInt()}',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Y轴配置（左侧）
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: true,
                                    // 设置Y轴刻度间隔
                                    interval: 5, // 每5个单位显示一个刻度
                                    getTitlesWidget: (value, meta) {
                                      // 只显示到35的刻度
                                      if (value > 35) {
                                        return SizedBox.shrink();
                                      }
                                      return Text(
                                        '${value.toInt()}',
                                        style: TextStyle(
                                            fontSize: 10, // 字体大小10
                                            color: Colors.white),
                                      );
                                    }),
                              ),
                              // 隐藏顶部和右侧的轴
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
                            // 配置轴线
                            borderData: FlBorderData(
                              show: true,
                              border: Border(
                                bottom: BorderSide(color: Colors.white), // X轴线
                                left: BorderSide(color: Colors.white), // Y轴线
                                top: BorderSide.none, // 隐藏顶部边框
                                right: BorderSide.none, // 隐藏右侧边框
                              ),
                            ),
                            lineTouchData: LineTouchData(
                              enabled: true,
                              handleBuiltInTouches: false, // 隐藏默认触摸指示器
                              touchCallback: (event, response) {
                                if (event is FlTapUpEvent && response != null && response.lineBarSpots != null) {
                                  // 获取第一个触摸到的点
                                  final touchedSpot = response.lineBarSpots!.first;

                                  setState(() {
                                    // 直接使用触摸到的点坐标
                                    _selectedSpot = FlSpot(touchedSpot.x, touchedSpot.y);
                                  });
                                  _showTooltip(touchedSpot,_chartKey2);

                                  log.i("选中的点: ${_selectedSpot}");
                                } else {
                                  // 点击空白处隐藏悬浮窗和选中点
                                  setState(() {
                                    _selectedSpot = null; // 确保选中状态被清除
                                  });
                                  _hideTooltip();
                                }
                              },
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 35),
                                  FlSpot(5, 30),
                                  FlSpot(10, 28),
                                  FlSpot(15, 24),
                                  FlSpot(20, 20),
                                  FlSpot(30, 19),
                                  FlSpot(40, 22),
                                  FlSpot(50, 25),
                                ],
                                isCurved: true,
                                color: Color.fromRGBO(235, 130, 62, 1),
                                barWidth: 2,
                                // 白色数据点
                                dotData: FlDotData(
                                    show: true,
                                    getDotPainter: (spot, percent, barData, index) {
                                      bool isSelected = _selectedSpot != null &&
                                          _selectedSpot!.x == spot.x &&
                                          _selectedSpot!.y == spot.y;

                                      if (isSelected) {
                                        // 选中的点：宽11高11的圆形，白色透明度0.5
                                        return _SelectedDotPainter(centerDotColor: Color.fromRGBO(235, 130, 62, 1));
                                      } else {
                                        return FlDotCirclePainter(
                                          radius: 2.5,
                                          color: Color.fromRGBO(235, 130, 62, 1),
                                          strokeWidth: 1,
                                          strokeColor: Color.fromRGBO(235, 130, 62, 1),
                                        );
                                      }
                                    }

                                ),
                                // 添加阴影填充
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(255, 159, 97, 1), // 上方颜色
                                      Color.fromRGBO(195, 195, 195, 1), // 下方颜色
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              )
                            ])),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 17),
                    child: Text(
                      "场次",
                      style: AllTextStyle.f8White,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else if (currentRightMostImage == "传球趋势") {
      return Container(
        width: Get.width,
        height: 262,
        padding: EdgeInsets.fromLTRB(13, 9, 9, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _flipState = RotatorFlipState.showFirst;
                    });
                    // 切换页面时隐藏悬浮窗
                    _hideTooltip();
                    setState(() {
                      _selectedSpot = null; // 确保选中状态被清除
                    });
                  },
                  child: Image.asset(
                    "images/tuceng.png",
                    width: 16,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(13, 0, 0, 5),
                  child: Text(
                    "次数",
                    style: AllTextStyle.f8White,
                  ),
                )
              ],
            ),
            Container(
              key: _chartKey3,
              height: 204,
              width: double.infinity, // 占满父组件宽度,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: Container(
                        child: LineChart(LineChartData(
                            minX: 0,
                            maxX: 52,
                            minY: 0,
                            maxY: 37,
                            // 配置网格线
                            gridData: FlGridData(
                              show: true,
                              // X轴网格线配置
                              horizontalInterval: 1, // Y轴不显示网格线，设置为1但不显示
                              getDrawingHorizontalLine: (value) {
                                // Y轴不显示网格线
                                return FlLine(
                                  color: Colors.transparent,
                                  strokeWidth: 0,
                                );
                              },
                              // X轴网格线配置
                              verticalInterval: 5, // 每5格显示一条虚线
                              getDrawingVerticalLine: (value) {
                                // 只在X轴每5格显示虚线
                                return FlLine(
                                  color: Color.fromRGBO(90, 90, 90, 1), // 虚线颜色
                                  strokeWidth: 0.5,
                                  dashArray: [2, 0], // 虚线样式 [线段长度, 间隔长度]
                                );
                              },
                            ),
                            // 配置坐标轴标签
                            titlesData: FlTitlesData(
                              // X轴配置（底部）
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  interval: 5,
                                  getTitlesWidget: (value, meta) {
                                    // X轴只在value>0时显示标签，避免与Y轴0点重复
                                    if (value == 0) {
                                      return SizedBox.shrink(); // 不显示X轴的0
                                    }
                                    // 只显示到50的刻度
                                    if (value > 50) {
                                      return SizedBox.shrink();
                                    }
                                    return Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Text(
                                        '${value.toInt()}',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              // Y轴配置（左侧）
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                    showTitles: true,
                                    // 设置Y轴刻度间隔
                                    interval: 5, // 每5个单位显示一个刻度
                                    getTitlesWidget: (value, meta) {
                                      // 只显示到35的刻度
                                      if (value > 35) {
                                        return SizedBox.shrink();
                                      }
                                      return Text(
                                        '${value.toInt()}',
                                        style: TextStyle(
                                            fontSize: 10, // 字体大小10
                                            color: Colors.white),
                                      );
                                    }),
                              ),
                              // 隐藏顶部和右侧的轴
                              topTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                              rightTitles: AxisTitles(
                                  sideTitles: SideTitles(showTitles: false)),
                            ),
                            // 配置轴线
                            borderData: FlBorderData(
                              show: true,
                              border: Border(
                                bottom: BorderSide(color: Colors.white), // X轴线
                                left: BorderSide(color: Colors.white), // Y轴线
                                top: BorderSide.none, // 隐藏顶部边框
                                right: BorderSide.none, // 隐藏右侧边框
                              ),
                            ),
                            lineTouchData: LineTouchData(
                              enabled: true,
                              handleBuiltInTouches: false, // 隐藏默认触摸指示器
                              touchCallback: (event, response) {
                                if (event is FlTapUpEvent && response != null && response.lineBarSpots != null) {
                                  // 获取第一个触摸到的点
                                  final touchedSpot = response.lineBarSpots!.first;

                                  setState(() {
                                    // 直接使用触摸到的点坐标
                                    _selectedSpot = FlSpot(touchedSpot.x, touchedSpot.y);
                                  });
                                  _showTooltip(touchedSpot,_chartKey3);

                                  log.i("选中的点: ${_selectedSpot}");
                                } else {
                                  // 点击空白处隐藏悬浮窗和选中点
                                  setState(() {
                                    _selectedSpot = null; // 确保选中状态被清除
                                  });
                                  _hideTooltip();
                                }
                              },
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: [
                                  FlSpot(0, 28),
                                  FlSpot(5, 13),
                                  FlSpot(10, 8),
                                  FlSpot(15, 12),
                                  FlSpot(20, 11),
                                  FlSpot(30, 8),
                                  FlSpot(40, 9),
                                  FlSpot(50, 13),
                                ],
                                isCurved: true,
                                color: Color.fromRGBO(217, 238, 255, 1),
                                barWidth: 2,
                                // 白色数据点
                                dotData: FlDotData(
                                    show: true,
                                    getDotPainter: (spot, percent, barData, index) {
                                      bool isSelected = _selectedSpot != null &&
                                          _selectedSpot!.x == spot.x &&
                                          _selectedSpot!.y == spot.y;

                                      if (isSelected) {
                                        // 选中的点：宽11高11的圆形，白色透明度0.5
                                        return _SelectedDotPainter(centerDotColor: Color.fromRGBO(119, 180, 239, 1));
                                      } else {
                                        return FlDotCirclePainter(
                                          radius: 2.5,
                                          color: Color.fromRGBO(119, 180, 239, 1),
                                          strokeWidth: 1,
                                          strokeColor: Color.fromRGBO(119, 180, 239, 1),
                                        );
                                      }
                                    }

                                ),
                                // 添加阴影填充
                                belowBarData: BarAreaData(
                                  show: true,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromRGBO(32, 146, 255, 1), // 上方颜色
                                      Color.fromRGBO(164, 172, 177, 1), // 下方颜色
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                              )
                            ])),
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 17),
                    child: Text(
                      "场次",
                      style: AllTextStyle.f8White,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        width: Get.width,
        height: 262,
        padding: EdgeInsets.fromLTRB(13, 9, 9, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _flipState = RotatorFlipState.showFirst;
                      // 切换页面时隐藏悬浮窗
                      _hideTooltip();
                      setState(() {
                        _selectedSpot = null; // 确保选中状态被清除
                      });
                    });
                  },
                  child: Image.asset(
                    "images/tuceng.png",
                    width: 16,
                    fit: BoxFit.contain,
                  ),
                )
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(13, 0, 0, 5),
                  child: Text(
                    "次数",
                    style: AllTextStyle.f8White,
                  ),
                )
              ],
            ),
            Container(
              key: _chartKey1, // 添加key用于获取位置
              height: 204,
              width: double.infinity, // 占满父组件宽度,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: LineChart(LineChartData(
                          minX: 0,
                          maxX: 52,
                          minY: 0,
                          maxY: 37,
                          // 配置网格线
                          gridData: FlGridData(
                            show: true,
                            // X轴网格线配置
                            horizontalInterval: 1, // Y轴不显示网格线，设置为1但不显示
                            getDrawingHorizontalLine: (value) {
                              // Y轴不显示网格线
                              return FlLine(
                                color: Colors.transparent,
                                strokeWidth: 0,
                              );
                            },
                            // X轴网格线配置
                            verticalInterval: 5, // 每5格显示一条虚线
                            getDrawingVerticalLine: (value) {
                              // 只在X轴每5格显示虚线
                              return FlLine(
                                color: Color.fromRGBO(90, 90, 90, 1), // 虚线颜色
                                strokeWidth: 0.5,
                                dashArray: [2, 0], // 虚线样式 [线段长度, 间隔长度]
                              );
                            },
                          ),
                          // 配置坐标轴标签
                          titlesData: FlTitlesData(
                            // X轴配置（底部）
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 5,
                                getTitlesWidget: (value, meta) {
                                  // X轴只在value>0时显示标签，避免与Y轴0点重复
                                  if (value == 0) {
                                    return SizedBox.shrink(); // 不显示X轴的0
                                  }
                                  // 只显示到50的刻度
                                  if (value > 50) {
                                    return SizedBox.shrink();
                                  }
                                  return Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Text(
                                      '${value.toInt()}',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.white),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Y轴配置（左侧）
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                  showTitles: true,
                                  // 设置Y轴刻度间隔
                                  interval: 5, // 每5个单位显示一个刻度
                                  getTitlesWidget: (value, meta) {
                                    // 只显示到35的刻度
                                    if (value > 35) {
                                      return SizedBox.shrink();
                                    }
                                    return Text(
                                      '${value.toInt()}',
                                      style: TextStyle(
                                          fontSize: 10, // 字体大小10
                                          color: Colors.white),
                                    );
                                  }),
                            ),
                            // 隐藏顶部和右侧的轴
                            topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                          ),
                          // 配置轴线
                          borderData: FlBorderData(
                            show: true,
                            border: Border(
                              bottom: BorderSide(color: Colors.white), // X轴线
                              left: BorderSide(color: Colors.white), // Y轴线
                              top: BorderSide.none, // 隐藏顶部边框
                              right: BorderSide.none, // 隐藏右侧边框
                            ),
                          ),
                          lineTouchData: LineTouchData( // 添加触摸交互配置
                            // touchTooltipData: LineTouchTooltipData(
                            //   tooltipRoundedRadius: 5.5, // 设置圆角
                            //   tooltipPadding: EdgeInsets.fromLTRB(5.5 ,1, 5.5, 1),
                            //   fitInsideHorizontally: true, // 水平方向适应
                            //   fitInsideVertically: true, // 垂直方向适应
                            //   getTooltipItems: (touchedSpots) {
                            //     return touchedSpots.map((touchedSpot) {
                            //       return LineTooltipItem(
                            //         '${touchedSpot.y.toInt()}',
                            //         TextStyle(
                            //           color: Color.fromRGBO(34, 34, 34, 1),
                            //           fontSize: 8,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //         // 添加文字对齐和边距
                            //         textAlign: TextAlign.center,
                            //       );
                            //     }).toList();
                            //   },
                            //   getTooltipColor: (touchedSpot) => Colors.white, // 背景颜色
                            // ),
                            // handleBuiltInTouches: true, // 启用内置触摸处理
                            enabled: true,
                            handleBuiltInTouches: false, // 隐藏默认触摸指示器
                            touchCallback: (event, response) {
                              if (event is FlTapUpEvent && response != null && response.lineBarSpots != null) {
                                // 获取第一个触摸到的点
                                final touchedSpot = response.lineBarSpots!.first;

                                setState(() {
                                  // 直接使用触摸到的点坐标
                                  _selectedSpot = FlSpot(touchedSpot.x, touchedSpot.y);
                                });
                                _showTooltip(touchedSpot,_chartKey1);

                                log.i("选中的点: ${_selectedSpot}");
                              } else {
                                // 点击空白处隐藏悬浮窗和选中点
                                setState(() {
                                  _selectedSpot = null; // 确保选中状态被清除
                                });
                                _hideTooltip();
                              }
                            },
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: [
                                FlSpot(0, 15),
                                FlSpot(5, 25),
                                FlSpot(10, 22),
                                FlSpot(15, 18),
                                FlSpot(20, 10),
                                FlSpot(30, 20),
                                FlSpot(40, 25),
                                FlSpot(50, 15),
                              ],
                              isCurved: true,
                              color: Color.fromRGBO(174, 49, 73, 1),
                              barWidth: 2,
                              // 白色数据点
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  // 检查是否是选中的点
                                  bool isSelected = _selectedSpot != null &&
                                      _selectedSpot!.x == spot.x &&
                                      _selectedSpot!.y == spot.y;

                                  if (isSelected) {
                                    // 选中的点：宽11高11的圆形，白色透明度0.5
                                    return _SelectedDotPainter(centerDotColor: Color.fromRGBO(164, 47, 69, 1));
                                  } else {
                                    // 普通点：保持原样
                                    return FlDotCirclePainter(
                                      radius: 2.5,
                                      color: Color.fromRGBO(164, 47, 69, 1),
                                      strokeWidth: 1,
                                      strokeColor: Color.fromRGBO(164, 47, 69, 1),
                                    );
                                  }
                                },
                              ),
                              // 添加阴影填充
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(222, 87, 87, 1), // 上方颜色
                                    Color.fromRGBO(69, 81, 116, 1), // 下方颜色
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            )
                          ]))),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 0, 17),
                    child: Text(
                      "场次",
                      style: AllTextStyle.f8White,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  // 页面弹窗
  Widget _buildShowDiaog({required String title, required String content}) {
    return Dialog(
      // 去除默认边距约束
      insetPadding: EdgeInsets.symmetric(
          horizontal: (MediaQuery.of(context).size.width - 289) / 2),
      backgroundColor: Colors.transparent, // 背景透明
      elevation: 0, // 去除阴影
      child: Container(
        width: 289,
        height: 302,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/bg_jishu1.png'),
              fit: BoxFit.fill, // 确保图片充满容器
            ),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        padding: EdgeInsets.fromLTRB(31, 18, 18, 26),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 解决Column没有高度的问题 让Column只占用需要的空间
          children: [
            Container(
                width: 145,
                height: 42,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/bg_juxin2.png'),
                      fit: BoxFit.fill, // 确保图片充满容器
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(21))),
                child: Center(
                  child: Text(
                    title,
                    style: AllTextStyle.f14Black,
                  ),
                )),
            SizedBox(
              height: 22,
            ),
            Expanded(
                child: ListView(
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Text(
                      content,
                      style: AllTextStyle.f14Black,
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void _showTooltip(LineBarSpot touchedSpot,GlobalKey _chartKey) {
    // 移除之前的悬浮窗
    _hideTooltip();

    // 延迟一帧确保布局完成
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 获取图表在屏幕上的位置
      final RenderBox? chartBox = _chartKey.currentContext?.findRenderObject() as RenderBox?;
      if (chartBox == null) return;

      final chartOffset = chartBox.localToGlobal(Offset.zero);
      final chartSize = chartBox.size;

      // 计算数据点在图表中的相对位置
      final spotOffset = _calculateSpotOffset(touchedSpot, chartSize);

      // 创建悬浮窗
      _tooltipOverlayEntry = OverlayEntry(
        builder: (context) {
          return Positioned(
            left: chartOffset.dx + spotOffset.dx - 20, // 居中显示
            top: chartOffset.dy + spotOffset.dy - 25, // 在点上方显示
            child: _buildCustomTooltip(touchedSpot.y),
          );
        },
      );

      // 插入到Overlay
      Overlay.of(context).insert(_tooltipOverlayEntry!);
    });
  }

  // 计算数据点在图表中的位置
  Offset _calculateSpotOffset(FlSpot spot, Size chartSize) {
    // 考虑坐标轴和内边距
    const paddingLeft = 30.0;   // 左边距（Y轴标签区域）
    const paddingRight = 10.0;  // 右边距
    const paddingTop = 10.0;    // 上边距
    const paddingBottom = 30.0; // 下边距（X轴标签区域）

    final contentWidth = chartSize.width - paddingLeft - paddingRight;
    final contentHeight = chartSize.height - paddingTop - paddingBottom;

    // 计算X坐标
    final xRatio = spot.x / 52; // maxX = 52
    final xPixel = xRatio * contentWidth + paddingLeft;

    // 计算Y坐标（Y轴是反向的）
    final yRatio;
    if (selectedValue == "综合赛场趋势") {
      yRatio = 1 - (spot.y / 108); // maxY = 108
    } else {
      yRatio = 1 - (spot.y / 37); // maxY = 37
    }

    final yPixel = yRatio * contentHeight + paddingTop;

    return Offset(xPixel, yPixel);
  }

  void _hideTooltip() {
    _tooltipOverlayEntry?.remove();
    _tooltipOverlayEntry = null;
  }

  Widget _buildCustomTooltip(double yValue) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 19,
        height: 11,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '${yValue.toInt()}',
            style: TextStyle(
              color: Color.fromRGBO(34, 34, 34, 1),
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// 自定义选中点绘制器
class _SelectedDotPainter extends FlDotPainter {
  final Color centerDotColor; // 中心点颜色

  _SelectedDotPainter({required this.centerDotColor});
  @override
  Size getSize(FlSpot spot) => Size(11, 11);

  @override
  void draw(Canvas canvas, FlSpot spot, Offset offsetInCanvas) {
    // 绘制白色透明度0.5的背景圆形
    final backgroundPaint = Paint()
      ..color = Colors.white.withOpacity(0.5)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(offsetInCanvas, 5.5, backgroundPaint);

    // 在中心绘制原始数据点
    final dotPaint = Paint()
      ..color = centerDotColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(offsetInCanvas, 2.5, dotPaint);
  }

  @override
  FlDotPainter lerp(FlDotPainter a, FlDotPainter b, double t) => this;

  @override
  Color get mainColor => Colors.white.withOpacity(0.5);

  @override
  List<Object?> get props => [mainColor];
}