import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/loginData.dart';
import '../register/register.dart';
import '../userInfo/userInfo.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  FocusNode focusNodeUserName = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  bool isshowPassword = false;
  bool agreed = false;
  LqPasswordLoginData _passLoginData = LqPasswordLoginData();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _changeAccount(String text) {
    _passLoginData.username = text;
    print("_passLoginData.username:${_passLoginData.username}");
    setState(() {});
  }
  void _changePassWord(String text) {
    _passLoginData.password = text;
    print("_passLoginData.password:${_passLoginData.password}");
    setState(() {});
  }
  _jumpHomePage() {
    focusNodeUserName.unfocus();
    focusNodePassword.unfocus();
    Get.to(() => UserInfo(), transition: Transition.rightToLeft);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(16, 16, 16, 1),
        resizeToAvoidBottomInset: true, // 在输入框获取焦点的时候可以让ui可见
        body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(47, 117, 47, 0),
                  height: Get.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        // 添加 Center 组件
                        child: Image.asset("images/zuqiu.png", width: 92),
                      ),
                      SizedBox(
                        height: 85,
                      ),
                      Form(
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            children: [
                              TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _accountController,
                                  focusNode: focusNodeUserName,
                                  cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                  style: TextStyle(color: Colors.white),
                                  onChanged: (v) => _changeAccount(v),
                                  // maxLength: 11,
                                  decoration: InputDecoration(
                                    hintText: "账号",
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromRGBO(255, 255, 255, 1)),
                                    counterText: '',
                                    enabledBorder: UnderlineInputBorder( // 默认状态下的下划线
                                      borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5)),
                                    ),
                                    focusedBorder: UnderlineInputBorder( // 获取焦点时的下划线
                                      borderSide: BorderSide(color: Color.fromRGBO(226, 6, 19, 1)),
                                    ),
                                  )),
                              SizedBox(height: 40,),
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: !isshowPassword,
                                controller: _passController,
                                focusNode: focusNodePassword,
                                cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                style: TextStyle(color: Colors.white),
                                onChanged: (v) => _changePassWord(v),
                                decoration: InputDecoration(
                                  hintText: "密码",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromRGBO(255, 255, 255, 1)),
                                  counterText: '',
                                  enabledBorder: UnderlineInputBorder( // 默认状态下的下划线
                                    borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5)),
                                  ),
                                  focusedBorder: UnderlineInputBorder( // 获取焦点时的下划线
                                    borderSide: BorderSide(color: Color.fromRGBO(226, 6, 19, 1)),
                                  ),
                                  suffixIcon:GestureDetector(
                                    onTap: () => setState(() => isshowPassword = !isshowPassword),
                                    child: isshowPassword
                                        ? Icon(Icons.visibility_outlined,)
                                        : Icon(Icons.visibility_off_outlined,),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Text(
                                      "忘记密码",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromRGBO(255, 255, 255, 1)),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 70,),
                              GestureDetector(
                                onTap: (_accountController.text.length > 0 &&
                                    _passController.text.length > 0)
                                    ? () => _jumpHomePage()
                                    : null,
                                child: Container(
                                  width: 200,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(16)),
                                    image: DecorationImage(
                                      image: AssetImage('images/bg_login.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '登录',
                                      style: TextStyle(
                                        color: Color.fromRGBO(16, 16, 16, 1),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 26,),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => Register(), transition: Transition.rightToLeft);
                                },
                                child: Container(
                                  width: 200,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(16, 16, 16, 1),
                                    borderRadius: BorderRadius.circular(28),
                                    border: Border.all(
                                      color: Colors.white, // 白色边框
                                      width: 1, // 边框粗细
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '注册',
                                      style: TextStyle(
                                        color: Color.fromRGBO(140, 140, 140, 1),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ))
                    ],
                  ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Checkbox(
                              value: agreed,
                              onChanged: (e) {
                                setState(() {
                                  agreed = e!;
                                });
                              },
                              // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // 去掉默认的点击区域
                              activeColor: Color.fromRGBO(226, 6, 19, 1),
                              // 选中状态的颜色为绿色
                              checkColor: Colors.white, // 选中标记的颜色为白色
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "我已同意并阅读隐私保护协议",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(255, 255, 255, 1)),
                        )
                      ],
                    ))

              ],
            )

        ),
      ),
    );

  }
}
