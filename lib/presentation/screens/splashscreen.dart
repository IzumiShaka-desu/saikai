import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saikai/constant/color_pallete.dart';
import 'package:saikai/presentation/controller/auth_controller.dart';
import 'onboard.dart';
import 'pagecontainer.dart';
import 'package:saikai/service/spref_service.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final AuthController authController = Get.put(AuthController(),tag: "ac");
  bool isAnimate = false;
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () {
        setState(
          () {
            isAnimate = true;
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.width * 0.1),
                      child: Image.asset(
                        'images/icon.png',
                        width: size.height * 0.60,
                      ),
                    ),
                    Text(
                      'SaikaiApp',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    )
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              left: (isAnimate)
                  ? -((size.height - size.width) / 2)
                  : size.width / 2,
              top: (isAnimate) ? -300 : size.height / 2,
              duration: Duration(milliseconds: 295),
              child: AnimatedContainer(
                height: size.height + 600,
                width: size.height + 600,
                onEnd: () => goToNext(),
                decoration: BoxDecoration(
                    color: ColorPallete.mainBlue, shape: BoxShape.circle),
                transform: Matrix4.identity()
                  ..scale((isAnimate) ? 1.0 : 0.0005),
                duration: Duration(milliseconds: 300),
              ),
            )
          ],
        ),
      ),
    );
  }

  goToNext() async {
    bool seen = await SPrefService().isSeen();
    print(seen);
    Widget page = seen ? PageContainer() : OnBoard();
    Get.off(page);
  }
}
