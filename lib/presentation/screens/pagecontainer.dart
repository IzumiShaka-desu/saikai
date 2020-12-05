import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saikai/constant/color_pallete.dart';
import 'package:saikai/presentation/controller/auth_controller.dart';
import 'package:saikai/presentation/screens/home.dart';
import 'package:saikai/presentation/screens/login.dart';

class PageContainer extends StatelessWidget {
  final AuthController _authController = Get.find(tag: "ac");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Obx(
        () => Container(
          color: ColorPallete.mainWhite,
          child: _authController.loginStatus.isNull
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : _authController.loginStatus.value
                  ? Home()
                  : Login(),
        ),
      ),
    );
  }
}
