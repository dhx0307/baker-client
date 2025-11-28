
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../model/loginData.dart';
import '../../utils/request.dart';
import '../../utils/tokenStorage/tokenStorage.dart';

class LoginLogic extends GetxController {
  register(String mobile, String password) async {
    var res = await Request.instance?.request("/usercenter/v1/user/register",
        method: DioMethod.post, data: {"mobile": mobile, "password": password});
    print("register:$res");
    return res;
  }

  login(String mobile, String password) async {
    var res = await Request.instance?.request("/usercenter/v1/user/login",
        method: DioMethod.post, data: {"mobile": mobile, "password": password});
    await TokenStorage.storeToken(res['accessToken']);
    print("login:$res");
    return LoginResponseData.fromJson(res);
  }
}