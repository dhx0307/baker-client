import 'package:flutter/material.dart';

/// 动态线段绘制组件
class AnimatedLines extends StatefulWidget {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final Duration duration;

  const AnimatedLines({
    Key? key,
    required this.points,
    this.color = Colors.red,
    this.strokeWidth = 2.0,
    this.duration = const Duration(seconds: 1),
  }) : super(key: key);

  @override
  _AnimatedLinesState createState() => _AnimatedLinesState();
}

class _AnimatedLinesState extends State<AnimatedLines>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: LinePainter(
            points: widget.points,
            color: widget.color,
            strokeWidth: widget.strokeWidth,
            progress: _controller.value,
          ),
        );
      },
    );
  }
}

/// 线段绘制组件
/// [points] 线段点列表
/// [color] 线段颜色
/// [strokeWidth] 线宽
/// [progress] 绘制进度 (0.0~1.0)
class LinePainter extends CustomPainter {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final double progress;

  LinePainter({
    required this.points,
    this.color = Colors.red,
    this.strokeWidth = 2.0,
    this.progress = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()..moveTo(points[0].dx, points[0].dy);

    // 计算总长度
    double totalLength = 0;
    final segmentLengths = <double>[];
    for (int i = 1; i < points.length; i++) {
      final length = (points[i] - points[i - 1]).distance;
      segmentLengths.add(length);
      totalLength += length;
    }

    // 动态绘制
    double currentLength = totalLength * progress;
    double accumulatedLength = 0;

    for (int i = 1; i < points.length; i++) {
      final segmentLength = segmentLengths[i - 1];
      if (accumulatedLength + segmentLength >= currentLength) {
        final ratio = (currentLength - accumulatedLength) / segmentLength;
        final end = Offset(
          points[i - 1].dx + (points[i].dx - points[i - 1].dx) * ratio,
          points[i - 1].dy + (points[i].dy - points[i - 1].dy) * ratio,
        );
        path.lineTo(end.dx, end.dy);
        break;
      } else {
        path.lineTo(points[i].dx, points[i].dy);
        accumulatedLength += segmentLength;
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate.points != points ||
        oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}