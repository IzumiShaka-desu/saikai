import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:saikai/model/food_category.dart';
import 'package:saikai/model/recipe.dart';
import 'package:saikai/service/network_service.dart';

class MainController extends GetxController {
  var _recipes = <Recipe>[].obs;
  RxBool isLoadingRecipes = false.obs;
  RxList<FoodCategory> _categories = <FoodCategory>[].obs;
  RxList<Recipe> get recipes => _recipes;
  RxList<FoodCategory> get categories => _categories;
  Rx<Widget> iconDarkmode = Icon(Icons.wb_sunny_outlined).obs;
  final NetworkService _networkService = NetworkService();
  var pages = <Widget>[].obs;
  var filter = <String>[].obs;
  get filteredRecipes => filter.length < 1
      ? _recipes
      : _recipes.where(
          (element) => filter.contains(element.idCategory),
        ).toList();
  var selectedIndex = 0.obs;

  Widget get currentPage => pages[selectedIndex.value];
  @override
  void onInit() {
    loadRecipes();
    super.onInit();
  }

  addFilter(String newFilter) {
    if (filter.contains(newFilter))
      filter.removeWhere((element) => element == newFilter);
    else
      filter.add(newFilter);
  }

  changeThemeMode() {
    if (Get.isDarkMode) {
      iconDarkmode.value = Icon(Icons.wb_sunny_outlined);
      Get.changeThemeMode(ThemeMode.light);
    } else {
      iconDarkmode.value = Icon(Icons.nightlight_round);
      Get.changeThemeMode(ThemeMode.dark);
    }
  }

  Future<void> loadRecipes() async {
    isLoadingRecipes.value = true;
    try {
      var result = await Future.wait(
        [
          _networkService.getRecipes(),
          _networkService.getCategories(),
        ],
      );
      _recipes = (result[0] as List<Recipe>).obs;
      _categories = (result[1] as List<FoodCategory>).obs;
    } catch (e) {
      printError(
        info: e.toString(),
      );
    }
    isLoadingRecipes.value = false;
  }
}
