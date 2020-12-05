import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saikai/constant/color_pallete.dart';
import 'pagecontainer.dart';
import 'package:saikai/service/spref_service.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  final List<String> images = [
    'images/explorerecipe.png',
    'images/tryrecipe.png',
    'images/sharerecipe.png',
  ];

  final List<String> desc = [
    'explore a variety of recipes from around the world',
    'try different recipes from different countries',
    'share your best recipes to the world'
  ];
  double position = 0;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    _controller.addListener(
      () {
        setState(
          () {
            position = _controller.page;
          },
        );
      },
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
          child: Column(
            children: [
              Container(
                height: 30,
                child: DotsIndicator(
                  position: position,
                  dotsCount: images.length,
                ),
              ),
              Expanded(
                child: Container(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: images.length,
                    itemBuilder: (ctx, index) => Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 0, 8, 5),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text.rich(
                                      TextSpan(
                                        text: desc[index].split(" ")[0],
                                        style: Get.textTheme.headline6.copyWith(
                                          color: ColorPallete.mainOrange,
                                        ),
                                        children: [
                                          TextSpan(
                                              text: desc[index].replaceFirst(
                                                  desc[index].split(" ")[0],
                                                  " "),
                                              style: Get.textTheme.headline6)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: Get.height / 10,
                width: double.infinity,
                child: Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            color: Colors.blue,
                            onPressed: () async {
                              await SPrefService().setSeen();
                              Get.offAll(
                                PageContainer(),
                              );
                            },
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                color: ColorPallete.mainWhite,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
