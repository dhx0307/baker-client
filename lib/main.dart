import 'package:bakersoccer/tabs/homeCareView.dart';
import 'package:bakersoccer/tabs/personalView.dart';
import 'package:bakersoccer/tabs/technologicalAnalysisView.dart';
import 'package:bakersoccer/ui/login/login.dart';
import 'package:bakersoccer/utils/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  //用于确保Flutter的Widgets绑定已经初始化。
  WidgetsFlutterBinding.ensureInitialized();
  // 设置应用仅支持竖屏
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // 设置应用全屏
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge, //状态栏和导航栏可见
  );
  // 设置状态栏和导航栏样式
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // 状态栏背景透明
      statusBarIconBrightness: Brightness.light, // 状态栏图标亮色
      systemNavigationBarColor: Colors.transparent, // 导航栏背景透明
      systemNavigationBarIconBrightness: Brightness.light, // 导航栏图标亮色
    ),
  );
  // 初始化通知帮助类
  NotificationHelper notificationHelper = NotificationHelper();
  await notificationHelper.initialize();

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    navigatorKey: navigatorKey,
    title: "贝克足球",
    home: StartApp(),
    theme: ThemeData(
      // 设置光标颜色和粘贴等颜色
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: Color.fromRGBO(226, 6, 19, 1),
          cursorColor: Color.fromRGBO(226, 6, 19, 1),
          selectionHandleColor: Color.fromRGBO(226, 6, 19, 1)),
    ),
    locale: const Locale('zh', 'CN'),
    // 确保应用默认语言为中文
    fallbackLocale: const Locale('zh', 'CN'),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('zh', 'CN'), // 支持中文
      Locale('en', 'US'), // 支持英文
    ],
    builder: FlutterSmartDialog.init(),
  ));
}

class LqHomeCareApp extends StatefulWidget {
  const LqHomeCareApp({super.key});

  @override
  State<LqHomeCareApp> createState() => _LqHomeCareAppState();
}

class _LqHomeCareAppState extends State<LqHomeCareApp> {
  int _currentIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior =
      NavigationDestinationLabelBehavior.alwaysHide; // 隐藏底部菜单文字
  List<dynamic> tabs = const [
    HomeCareView(),
    TechnologicalAnalysisView(),
    PersonalView()
  ];
  final List<ImageProvider> _unselectedIcons = [
    const AssetImage("images/tab1.png"),
    const AssetImage("images/tab2.png"),
    const AssetImage("images/tab3.png"),
  ];

  final List<ImageProvider> _selectedIcons = [
    const AssetImage("images/tab1.png"),
    const AssetImage("images/tab2.png"),
    const AssetImage("images/tab3.png"),
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(16, 16, 16, 1),
        body: tabs[_currentIndex],
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(6, 0, 6, 17),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(34.25),
            child: Container(
              height: 57,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bg_tabBar.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: NavigationBar(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  // 覆盖层颜色
                  backgroundColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  labelBehavior: labelBehavior,
                  indicatorShape: const CircleBorder(),
                  destinations: [
                    NavigationDestination(
                        icon: ImageIcon(
                          _currentIndex == 0
                              ? _selectedIcons[0]
                              : _unselectedIcons[0],
                          color: _currentIndex == 0
                              ? const Color.fromRGBO(226, 6, 19, 1)
                              : Colors.black,
                          size: 20,
                        ),
                        label: '首页'),
                    NavigationDestination(
                        icon: ImageIcon(
                          _currentIndex == 1
                              ? _selectedIcons[1]
                              : _unselectedIcons[1],
                          color: _currentIndex == 1
                              ? const Color.fromRGBO(226, 6, 19, 1)
                              : Colors.black,
                          size: 20,
                        ),
                        label: '技术分析'),
                    NavigationDestination(
                        icon: ImageIcon(
                          _currentIndex == 2
                              ? _selectedIcons[2]
                              : _unselectedIcons[2],
                          color: _currentIndex == 2
                              ? const Color.fromRGBO(226, 6, 19, 1)
                              : Colors.black,
                          size: 20,
                        ),
                        label: '个人'),
                  ],
                  selectedIndex: _currentIndex,
                  // height: 28.5,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  }),
            ),
          ),
        ));
  }
}

class StartApp extends StatefulWidget {
  const StartApp({super.key});

  @override
  State<StartApp> createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('startApp--initState-----');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isFirstLogin(); // 将你的导航操作移到这里 防止initState() 执行时 widget 尚未完全挂载到树中。
    });
    // 2秒后移除启动页
    // Future.delayed(const Duration(seconds: 2), () {
    //   FlutterNativeSplash.remove();
    // });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  _isFirstLogin() {
    Get.off(() => Login(), transition: Transition.rightToLeft);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(16, 16, 16, 1),
      body: Container(),
    );
  }
}

