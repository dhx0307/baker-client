import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../utils/log.dart';
import '../../../utils/style/textStyle.dart';

class QrScannerView extends StatefulWidget {
  const QrScannerView({super.key});

  @override
  State<QrScannerView> createState() => _QrScannerViewState();
}

class _QrScannerViewState extends State<QrScannerView>
    with WidgetsBindingObserver {
  late MobileScannerController _controller;
  bool _isFlashOn = false; // 手电筒状态
  final double _scanFrameSize = 250; // 扫描框大小

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // 初始化扫描控制器（支持前后置摄像头切换、手电筒）
    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal, // 扫描速度
      facing: CameraFacing.back, // 默认后置摄像头
      torchEnabled: _isFlashOn, // 手电筒初始状态
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose(); // 释放控制器
    super.dispose();
  }

  // 监听应用生命周期，切后台时暂停扫描
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _controller.stop(); // 暂停扫描
    } else if (state == AppLifecycleState.resumed) {
      _controller.start(); // 恢复扫描
    }
  }

  // 切换手电筒
  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      _controller.toggleTorch(); // 调用插件API切换手电筒
    });
  }

  // 处理扫描结果
  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final Barcode barcode = barcodes.first;
      if (barcode.rawValue != null) {
        log.i("扫描结果barcode.rawValue:${barcode.rawValue}");
        _controller.stop(); // 扫描到结果后停止扫描
        // 返回上一页并传递扫描结果
        Navigator.pop(context, barcode.rawValue);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          color: Colors.black.withOpacity(0.4),
        ),
        // 全屏扫描预览
        MobileScanner(
          controller: _controller,
          onDetect: _onDetect,
          errorBuilder: (context, error, child) => Center(
            child: Text(
              "扫描异常：${error}！请返回重新进入。",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        // 自定义遮罩（中间挖空扫描框区域）
        ClipPath(
          clipper: ScanFrameClipper(scanFrameSize: _scanFrameSize),
          child: Container(
            width: Get.width,
            height: Get.height,
            color: Color.fromRGBO(16, 16, 16, 1).withOpacity(0.4), // 半透明黑色遮罩
          ),
        ),
        // 中间扫描框
        _buildScanFrame(),

        Positioned(
          left: 0,
          top: 38,
          child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset(
                "images/back.png",
                width: 10,
                fit: BoxFit.contain,
              )),
        ),
        // 手电筒按钮
        Positioned(
            bottom: 125,
            child: GestureDetector(
              onTap: _toggleFlash,
              child: Image.asset(
                "images/torch.png",
                width: 52,
                fit: BoxFit.contain,
              ),
            )),
        // 扫描提示文字（底部）
        Positioned(
          bottom: Get.height / 2 - _scanFrameSize / 2 - 30,
          child: Text(
            "请将扫描框对准二维码",
            style: AllTextStyle.f12White,
          ),
        ),
      ],
    );
  }

  // 构建中间扫描框（自定义样式）
  Widget _buildScanFrame() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 扫描框边框
        Container(
          width: _scanFrameSize,
          height: _scanFrameSize,
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage('images/scan.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class ScanFrameClipper extends CustomClipper<Path> {
  final double scanFrameSize;
  final double cornerRadius; // 圆角半径
  ScanFrameClipper({required this.scanFrameSize,this.cornerRadius = 8.0,});

  @override
  Path getClip(Size size) {
    // 整个屏幕的路径（作为遮罩基础）
    final path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // 计算扫描框的位置（居中）
    final scanFrameLeft = (size.width - scanFrameSize) / 2;
    final scanFrameTop = (size.height - scanFrameSize) / 2;
    final scanFrameRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        scanFrameLeft,
        scanFrameTop,
        scanFrameSize,
        scanFrameSize,
      ),
      Radius.circular(cornerRadius), // 圆角半径
    );

    // 从整个屏幕路径中减去扫描框的路径（实现挖空效果）
    path.addRRect(scanFrameRRect);
    path.fillType = PathFillType.evenOdd; // 关键：设置填充规则为"奇偶规则"

    return path;
  }

  @override
  bool shouldReclip(covariant ScanFrameClipper oldClipper) {
    // 当扫描框大小变化时重新裁剪
    return oldClipper.scanFrameSize != scanFrameSize;
  }
}