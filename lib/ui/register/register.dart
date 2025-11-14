import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController _accountController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  FocusNode focusNodeUserName = FocusNode();
  FocusNode focusNodePassword = FocusNode();
  FocusNode focusNodeConfirmPassword = FocusNode();
  bool isshowPassword = false;
  bool agreed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  _jumpHomePage() {

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(16, 16, 16, 1),
        resizeToAvoidBottomInset: true,
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
                                  // onChanged: (v) => _changeAccount(v),
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
                                // onChanged: (v) => _changePassWord(v),
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
                                height: 40,
                              ),
                              TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: !isshowPassword,
                                  controller: _confirmPassController,
                                  focusNode: focusNodeConfirmPassword,
                                  cursorColor: Color.fromRGBO(226, 6, 19, 1),
                                  style: TextStyle(color: Colors.white),
                                  // onChanged: (v) => _changeAccount(v),
                                  // maxLength: 11,
                                  decoration: InputDecoration(
                                    hintText: "确认密码",
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
                              SizedBox(height: 103,),
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
                                      '注册',
                                      style: TextStyle(
                                        color: Color.fromRGBO(16, 16, 16, 1),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
