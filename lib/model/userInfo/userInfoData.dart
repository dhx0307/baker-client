import 'package:bakersoccer/model/basic/basic_data.dart';

class UserInfoData extends IacpPojo {
  int? id;
  String? mobile;
  String? nickname;
  int? sex;
  String? birth;
  String? avatar;
  int? height;
  int? weight;
  int? favTeam;
  int? favPlayer;
  int? pos;
  int? feet;
  String? sign;
  String? imei; // 设备Id

  UserInfoData(
      {this.id,
        this.mobile,
        this.nickname,
      this.sex,
      this.birth,
      this.avatar,
      this.height,
      this.weight,
      this.favTeam,
      this.favPlayer,
      this.pos,
      this.feet,
      this.sign,
      this.imei});

  factory UserInfoData.fromJson(Map<String, dynamic> json) {
    return UserInfoData(
      id: json['id'],
      mobile: json['mobile'],
      nickname: json['nickname'],
      sex: json['sex'],
      birth: json['birth'],
      avatar: json['avatar'],
      height: json['height'],
      weight: json['weight'],
      favTeam: json['favTeam'],
      favPlayer: json['favPlayer'],
      pos: json['pos'],
      feet: json['feet'],
      sign: json['sign'],
      imei: json['imei'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {
      'id': id,
      'mobile': mobile,
      'nickname': nickname,
      'sex': sex,
      'birth': birth,
      'avatar': avatar,
      'height': height,
      'weight': weight,
      'favTeam': favTeam,
      'favPlayer': favPlayer,
      'pos': pos,
      'feet': feet,
      'sign': sign,
      'imei': imei,
    };
    jsonMap.removeWhere((key, value) => value == null);
    return jsonMap;
  }
}
