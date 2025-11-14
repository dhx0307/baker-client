import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/log.dart';
import '../../../../utils/style/textStyle.dart';

class RightRunningPacePageView extends StatefulWidget {
  // 接收从父组件传递的动画因子
  final double visibleProgress;
  const RightRunningPacePageView({super.key,required this.visibleProgress,});

  @override
  State<RightRunningPacePageView> createState() => _RightRunningPacePageViewState();
}

class _RightRunningPacePageViewState extends State<RightRunningPacePageView> {

  // 圆的大小
  final double _largeCircle = 76;
  final double _mediumCircle = 66;
  final double _smallCircle = 59;
  final double _smallMostCircle = 47;

  @override
  Widget build(BuildContext context) {
    final sizeFactor = (0.75 + (widget.visibleProgress * 0.5)).clamp(0.75, 1.0);
    final opacity = (widget.visibleProgress + 0.5).clamp(0.0, 1.0);

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
                child: Text("体能分配",style: AllTextStyle.f10White,),
              ),
            ),),
          Positioned(
            left: 31,
            top: 51,
            child: AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                width: _largeCircle * sizeFactor,
                height: _largeCircle * sizeFactor,
                constraints: BoxConstraints(minHeight: 35, minWidth: 35), // 大圆最小尺寸可稍大
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
                    Text("0-20", style: AllTextStyle.f10Black1),
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
              opacity: opacity,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
              child: AnimatedContainer(
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
                width: _mediumCircle * sizeFactor,
                height: _mediumCircle * sizeFactor,
                padding: const EdgeInsets.only(left: 10),
                constraints: const BoxConstraints(
                  minWidth: 35,
                  minHeight: 35,
                ),
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("30%", style: AllTextStyle.f12Black1),
                    Text("21-45", style: AllTextStyle.f10Black1),
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
              opacity: opacity,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
              child: AnimatedContainer(
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
                width: _smallCircle * sizeFactor ,
                height: _smallCircle * sizeFactor,
                constraints: const BoxConstraints(
                  minWidth: 35,
                  minHeight: 35,
                ),
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
                    Text("46-70", style: AllTextStyle.f10Black1),
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
              opacity: opacity,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
              child: AnimatedContainer(
                curve: Curves.easeOut,
                duration: const Duration(milliseconds: 300),
                width: _smallMostCircle * sizeFactor,
                height: _smallMostCircle * sizeFactor,
                constraints: const BoxConstraints(
                  minWidth: 35,
                  minHeight: 35,
                ),
                padding: EdgeInsets.symmetric(vertical: 2),
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
                    Text("70之后", style: AllTextStyle.f10Black1),
                  ],
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
