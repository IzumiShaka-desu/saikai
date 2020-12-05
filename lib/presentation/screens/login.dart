import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saikai/constant/color_pallete.dart';
import 'package:saikai/constant/util.dart';
import 'package:saikai/presentation/controller/auth_controller.dart';
import 'package:saikai/presentation/screens/register.dart';

class Login extends StatelessWidget {
  final AuthController _authController = Get.find(tag: "ac");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: ColorPallete.mainWhite,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: Get.height / 5,
                  color: ColorPallete.mainBlue,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: circularRadius(
                          Get.height / 5,
                        ),
                      ),
                      color: ColorPallete.mainWhite,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: SizedBox(
                  height: Get.height / 3,
                  child: Container(
                    color: ColorPallete.mainBlue,
                  ),
                ),
              ),
              Positioned(
                bottom: Get.height / 10,
                child: Container(
                  height: Get.width,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: ColorPallete.mainWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: circularRadius(
                        0,
                      ),
                      topRight: circularRadius(
                        Get.width,
                      ),
                      bottomLeft: circularRadius(
                        0,
                      ),
                      bottomRight: circularRadius(
                        Get.width,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: Get.width / 2.2,
                  height: Get.width / 2.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: circularRadius(
                        Get.width / 2.2,
                      ),
                    ),
                    color: ColorPallete.mainWhite,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: circularRadius(
                          Get.width / 2.5,
                        ),
                      ),
                      color: ColorPallete.mainOrange,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: Get.width / 2,
                  height: (Get.width / 2.1) / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: circularRadius(
                        Get.width / 2,
                      ),
                    ),
                    color: ColorPallete.mainWhite,
                  ),
                  padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: circularRadius(
                          Get.width / 2,
                        ),
                      ),
                      color: ColorPallete.mainGrey,
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(top: 20),
                  child: Obx(
                    () => Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Text(
                            'Login',
                            style: Get.theme.textTheme.headline4,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: ColorPallete.mainGrey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextFormField(
                                style: TextStyle(
                                  color: ColorPallete.mainWhite,
                                ),
                                enabled: _authController.isLoginLoading.value
                                    ? false
                                    : true,
                                controller: _emailController,
                                decoration: createInputDecoration(
                                  label: 'email',
                                  prefixIcon: Icon(
                                    Icons.mail_outline,
                                  ),
                                ),
                                validator: (email) {
                                  if (email.isEmpty) {
                                    return "email cannot be null";
                                  } else if (!email.trim().isEmail) {
                                    return "it is not valid email";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: ColorPallete.mainGrey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: TextFormField(
                                enabled: _authController.isLoginLoading.value
                                    ? false
                                    : true,
                                controller: _passwordController,
                                validator: (password) {
                                  if (password.isEmpty) {
                                    return "password cannot be null";
                                  } else if (password.trim().length < 6) {
                                    return "password cannot be less then 6 character";
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: createInputDecoration(
                                  label: 'password',
                                  prefixIcon: Icon(
                                    Icons.vpn_key_outlined,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (_authController.isLoginSuccess.value)
                                  ? Container(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(Icons.check,
                                          color: ColorPallete.mainWhite),
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle),
                                    )
                                  : _authController.isLoginLoading.value
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: MaterialButton(
                                              onPressed: () => executeLogin(),
                                              child: Text(
                                                'login',
                                                style: Get.textTheme.subtitle2
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "don\'t have account ?, ",
                                style: Get.textTheme.bodyText1,
                              ),
                              InkWell(
                                onTap: () => Get.to(Register()),
                                child: Text(
                                  "Register now",
                                  style: Get.textTheme.bodyText1.copyWith(
                                    color: ColorPallete.mainBlue,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  executeLogin() async {
    if (_formKey.currentState.validate()) {
      _authController.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }
}
