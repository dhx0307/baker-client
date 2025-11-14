import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../log.dart';

class PermissionUtils {
  PermissionUtils();
  /// 请求文件权限
  Future<PermissionStatus> requestFilePermissions(BuildContext context) async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      // 用户已授予文件访问权限
    } else if (status.isDenied) {
      // 用户拒绝了权限请求，显示权限说明
      // status = await showPermissionExplanation(context);
    }
    return status;
  }

  // Future<PermissionStatus> showPermissionExplanation(BuildContext context) async {
  //   return await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('write_permission'.tr),
  //         content: Text('need_write_permission'.tr),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () async {
  //               exit(0);
  //             },
  //             child: Text('login_refuse'.tr),
  //           ),
  //           TextButton(
  //             onPressed: () async {
  //               // Navigator.of(context).pop();
  //               Navigator.of(context).pop(await Permission.storage.request());
  //             },
  //             child: Text('continue_request_permission'.tr),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  Future<PermissionStatus> requestLocationPermissions(BuildContext context) async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // 用户已授予文件访问权限
    } else if (status.isDenied) {
      // 用户拒绝了权限请求，显示权限说明
    }
    return status;
  }

  Future<bool> requestBluetoothPermissions() async {
    // Ios 不支持Permission.bluetoothScan,Permission.bluetoothConnect,

    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      // 如果需要的话
    ].request();

    if (Platform.isIOS) {
      if (statuses[Permission.bluetooth]!.isGranted) {
        // 权限已授权，可以继续执行蓝牙操作
        return true;
      } else {
        return false;
      }
    } else{
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < 31) {
        if (statuses[Permission.bluetooth]!.isGranted) {
          return true;
        } else {
          return false;
        }
      } else {
        if (statuses[Permission.bluetooth]!.isGranted &&
            statuses[Permission.bluetoothScan]!.isGranted &&
            statuses[Permission.bluetoothConnect]!.isGranted ) {
          // 权限已授权，可以继续执行蓝牙操作
          return true;
        } else {
          return false;
        }
      }
    }

  }

  Future<bool> requestCameraPermissions() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      // 用户已授予文件访问权限
      return true;
    } else if (status.isDenied) {
      // 用户拒绝了权限请求，显示权限说明
      return false;
    } else {
      return false;
    }
  }

  Future<bool> requestPhotoPermissions() async {
    if (Platform.isIOS) {
      return true;
    } else {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt < 33) {
        // 对于 Android 12 及以下版本，使用旧的存储权限
        var status = await Permission.storage.request();
        if (status.isGranted) {
          return true;
        } else if (status.isDenied || status.isPermanentlyDenied) {
          return false;
        } else {
          return false;
        }
      } else {
        // 对于 Android 13 及以上版本，使用新的媒体权限
        var status = await Permission.photos.request();
        if (status.isGranted) {
          return true;
        } else if (status.isDenied || status.isPermanentlyDenied) {
          return false;
        } else {
          return false;
        }
      }
    }
  }

  Future<bool> requestNotificationPermissions() async {
    // 检查当前权限状态
    final status = await Permission.notification.status;
    print('status:$status');

    // 如果已授予，直接返回true
    if (status.isGranted) {
      return true;
    }
    var result  = await Permission.notification.request();
    print('result:$result');

    // 处理请求结果
    if (result.isGranted) {
      return true;
    } else {
      return false;
    }
  }

}