import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/log.dart';
import '../../../../utils/style/textStyle.dart';

class LeftRunningPacePageView extends StatefulWidget {
  // 接收从父组件传递的动画因子
  final double visibleProgress;
  LeftRunningPacePageView({super.key, required this.visibleProgress,});

  @override
  State<LeftRunningPacePageView> createState() =>
      _LeftRunningPacePageViewState();
}

class _LeftRunningPacePageViewState extends State<LeftRunningPacePageView> {
  // 圆的大小
  final double _largeCircle = 76;
  final double _mediumCircle = 66;
  final double _smallCircle = 59;
  final double _smallMostCircle = 47;

  @override
  Widget build(BuildContext context) {
    // 根据动画因子计算当前大小和透明度
    // 大小：0.5倍到1倍（由小到大）
    // 透明度：0到1（由透明到显身）
    final currentSizeFactor = 0.5 + (widget.visibleProgress * 0.5);
    final currentOpacity = widget.visibleProgress;
;
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Padding( padding: EdgeInsets.fromLTRB(6, 7, 0, 0),
          child: Container(
            width: 100,
            height: 28,
            decoration: BoxDecoration(
                color: Color.fromRGBO(43, 43, 43, 1),
                borderRadius: BorderRadius.all(Radius.circular(26))
            ),
            child: Center(
              child: Text("跑动配速分配",style: AllTextStyle.f10White,),
            ),
          ),),
          Positioned(
            left: 31,
            top: 51,
            child: AnimatedOpacity(
              opacity: currentOpacity,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: _largeCircle * currentSizeFactor,
                height: _largeCircle * currentSizeFactor,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromRGBO(210, 142, 98, 0.9),
                      const Color.fromRGBO(216, 216, 216, 0.9),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("40%", style: AllTextStyle.f12Black1),
                    Text("高速", style: AllTextStyle.f10Black1),
                  ],
                ),
              ),
            ),
          ),

          // 中圆 - 66
          Positioned(
            left: 84,
            top: 51 + 28,
            child: AnimatedOpacity(
              opacity: currentOpacity,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
              child: AnimatedContainer(
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
                width: _mediumCircle * currentSizeFactor,
                height: _mediumCircle * currentSizeFactor,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color.fromRGBO(149, 79, 92, 0.9),
                      const Color.fromRGBO(246, 246, 246, 0.9),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("30%", style: AllTextStyle.f12Black1),
                    Text("中速", style: AllTextStyle.f10Black1),
                  ],
                ),
              ),
            ),
          ),

          // 小圆 - 59
          Positioned(
            left: 50,
            top: 59 + 51,
            child: AnimatedOpacity(
              opacity: currentOpacity,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
                width: _smallCircle * currentSizeFactor,
                height: _smallCircle * currentSizeFactor,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color.fromRGBO(67, 106, 143, 0.9),
                      const Color.fromRGBO(246, 246, 246, 0.9),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("20%", style: AllTextStyle.f12Black1),
                    Text("低速", style: AllTextStyle.f10Black1),
                  ],
                ),
              ),
            ),
          ),

          // 最小圆 - 47
          Positioned(
            left: 11,
            bottom: 39,
            child: AnimatedOpacity(
              opacity: currentOpacity,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: _smallMostCircle * currentSizeFactor,
                height: _smallMostCircle * currentSizeFactor,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      const Color.fromRGBO(67, 143, 102, 0.9),
                      const Color.fromRGBO(246, 246, 246, 0.9),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("10%", style: AllTextStyle.f12Black1),
                    Text("走动", style: AllTextStyle.f10Black1),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
