import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:saikai/presentation/controller/main_controller.dart';
import 'package:saikai/presentation/pages/home_page.dart';
import 'package:saikai/presentation/pages/my_recipe.dart';
import 'package:saikai/presentation/pages/profile_page.dart';

class Home extends StatelessWidget {
  final MainController _mainController = Get.put(MainController(),tag: "mc");
  @override
  Widget build(BuildContext context) {
    if (_mainController.pages.isEmpty)
      _mainController.pages.assignAll(
        [
          HomePage(),
          MyRecipe(),
          ProfilePage(),
        ],
      );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Image.asset('images/icon.png'),
        ),
        actions: [
          Obx(
            () => IconButton(
              icon: AnimatedSwitcher(
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                duration: Duration(seconds: 1),
                transitionBuilder: (child, animation) => ScaleTransition(
                  scale: animation,
                  child: child,
                ),
                child: _mainController.iconDarkmode.value,
              ),
              onPressed: () => _mainController.changeThemeMode(),
            ),
          ),
        ],
      ),
      body: Obx(
        () => SafeArea(
          child: SizedBox(
            height: Get.height,
            width: Get.width,
            child: Row(
              children: [
                Expanded(child: _mainController.currentPage),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => GNav(
          gap: 6,
          iconSize: 24,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          curve: Curves.elasticInOut,
          onTabChange: (int index) {
            _mainController.selectedIndex.value = index;
          },
          selectedIndex: _mainController.selectedIndex.value,
          tabs: [
            GButton(
              text: "Home",
              icon: Icons.home_outlined,
            ),
            GButton(
              text: "My Recipe",
              icon: Icons.my_library_books_outlined,
            ),
            GButton(
              text: "Profile",
              icon: Icons.account_circle_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
