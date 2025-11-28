import 'package:bakersoccer/model/basic/basic_data.dart';

class LqPasswordLoginData {
  String username = "";
  String password = "";
}

class LoginResponseData extends IacpPojo {
  int? uid;
  bool? getInfo;
  String? accessToken;

  LoginResponseData({this.uid, this.getInfo, this.accessToken});

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      uid: json['uid'],
      getInfo: json['getInfo'],
      accessToken: json['accessToken'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {
      'uid': uid,
      'getInfo': getInfo,
      'accessToken': accessToken,
    };
    jsonMap.removeWhere((key, value) => value == null);
    return jsonMap;
  }
}
