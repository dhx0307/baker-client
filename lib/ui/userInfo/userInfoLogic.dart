import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../model/userInfo/userInfoData.dart';
import '../../utils/request.dart';

class UserInfoLogic extends GetxController {
  getUserInfo() async {
    var res = await Request.instance?.request("/usercenter/v1/user/info", method: DioMethod.post);
    print("getUserInfo:$res");
    return UserInfoData.fromJson(res['userInfo']);
  }

  editUserInfo(UserInfoData userInfoData) async {
    Map<String, dynamic> mapTypeData = userInfoData.toJson();
    var res = await Request.instance?.request("/usercenter/v1/user/editUser", method: DioMethod.post,data: mapTypeData);
    print("editUserInfo:$res");
    return res;
  }
}