// 导入包
import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../ui/homeCare/measureBallPlace/beginBallGameing/beginBallGameingView.dart';

class NotificationHelper {
  // 使用单例模式进行初始化
  static final NotificationHelper _instance = NotificationHelper._internal();
  factory NotificationHelper() => _instance;
  NotificationHelper._internal();

  // FlutterLocalNotificationsPlugin是一个用于处理本地通知的插件，它提供了在Flutter应用程序中发送和接收本地通知的功能。
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final StreamController<NotificationResponse> _notificationStreamController =
  StreamController<NotificationResponse>.broadcast();

  Stream<NotificationResponse> get notificationStream =>
      _notificationStreamController.stream;

  // 初始化函数
  Future<void> initialize() async {
    // AndroidInitializationSettings是一个用于设置Android上的本地通知初始化的类
    // 使用了app_icon作为参数，这意味着在Android上，应用程序的图标将被用作本地通知的图标。
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    // 15.1是DarwinInitializationSettings，旧版本好像是IOSInitializationSettings（有些例子中就是这个）
    const DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    // 初始化
    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    // await _notificationsPlugin.initialize(initializationSettings);
    await _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        // 处理通知点击
        print("xxxxxxxxxxxxxxxxxxxxxx");
        print('通知被点击: ${response.payload}');
        // _notificationStreamController.add(response);
        Get.to(() => BeginBallGameingView(),
            transition: Transition.rightToLeft,preventDuplicates: false);
      },
    );
    // 检查是否是通过点击通知启动的App（冷启动场景）
    final NotificationAppLaunchDetails? launchDetails =
    await _notificationsPlugin.getNotificationAppLaunchDetails();
    if (launchDetails?.didNotificationLaunchApp ?? false) {
      // 处理冷启动时的通知点击
      final NotificationResponse? response = launchDetails!.notificationResponse;
      if (response != null) {
        print("xxxxxxxxxxxxxdwadwa");
        print('通知被点击（冷启动）: ${response.payload}');
        Get.to(() => BeginBallGameingView(),
            transition: Transition.rightToLeft, preventDuplicates: false);
      }
    }

  }

//  显示通知
  Future<void> showNotification(
      {required int id,required String title, required String body}) async {
    // 安卓的通知
    // 'your channel id'：用于指定通知通道的ID。
    // 'your channel name'：用于指定通知通道的名称。
    // 'your channel description'：用于指定通知通道的描述。
    // Importance.max：用于指定通知的重要性，设置为最高级别。
    // Priority.high：用于指定通知的优先级，设置为高优先级。
    // 'ticker'：用于指定通知的提示文本，即通知出现在通知中心的文本内容。
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your.channel.id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');

    // ios的通知
    const String darwinNotificationCategoryPlain = 'plainCategory';
    const DarwinNotificationDetails iosNotificationDetails =
    DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain, // 通知分类
    );
    // 创建跨平台通知
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidNotificationDetails,iOS: iosNotificationDetails);

    // 发起一个通知
    await _notificationsPlugin.show(
      id,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  /// 显示带进度条的通知
  Future<void> showProgressNotification({
    required int id,
    required String title,
    required String body,
    required int progress,
    required int maxProgress,
    bool indeterminate = false,
    String? channelId,
    String? channelName,
  }) async {
    final AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
      'progress_channel',
      'Progress Notifications',
      channelDescription: 'Progress notification channel',
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
      onlyAlertOnce: true,
      showProgress: true,
      maxProgress: maxProgress,
      progress: progress,
      indeterminate: indeterminate,
    );

    final DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }

  /// 更新进度通知
  Future<void> updateProgressNotification({
    required int id,
    required String title,
    required String body,
    required int progress,
    required int maxProgress,
  }) async {
    await showProgressNotification(
      id: id,
      title: title,
      body: body,
      progress: progress,
      maxProgress: maxProgress,
    );
  }

  /// 取消通知
  Future<void> cancelNotification(int id) async {
    await _notificationsPlugin.cancel(id);
  }

  /// 取消所有通知
  Future<void> cancelAllNotifications() async {
    await _notificationsPlugin.cancelAll();
  }

  Timer? _timer;
  int _elapsed = 0;
  int _totalSeconds = 60;
  void startDynamicNotification() {
    _elapsed = 0;
    _timer?.cancel();
    _sendNotification();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_elapsed < _totalSeconds) {
        _elapsed++;
        _sendNotification();
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> _sendNotification() async {
    int progress = (((_elapsed / _totalSeconds) * 100).toInt()).clamp(0, 100);
    String elapsedStr = _formatElapsed(_elapsed);

    var androidDetails = AndroidNotificationDetails(
      'baker_soccer_channel',
      'BakerSoccer通知',
      channelDescription: '动态计时与进度',
      importance: Importance.max,
      priority: Priority.high,
      showProgress: true,
      maxProgress: 100,
      progress: progress,
      onlyAlertOnce: true,
      // largeIcon和style可以自定义
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      3, // 用同一个ID，实现覆盖
      '比赛中 | Baker Soccer',
      '比赛已经开始  $elapsedStr  | 浦东体育馆',
      notificationDetails,
      payload: '进入比赛',
    );
  }

  String _formatElapsed(int seconds) {
    final d = Duration(seconds: seconds);
    String mm = d.inMinutes.toString().padLeft(2, '0');
    String ss = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$mm:$ss";
  }





}