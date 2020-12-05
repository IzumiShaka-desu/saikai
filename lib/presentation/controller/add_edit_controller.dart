import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saikai/constant/color_pallete.dart';
import 'package:saikai/model/food_category.dart';
import 'package:saikai/model/recipe.dart';
import 'package:saikai/service/network_service.dart';

class AddEditController extends GetxController {
  RxString title = ''.obs;
  String idRecipe;
  String foto;
  RxString idCategory = '1'.obs;
  var steps = <String>[].obs;
  var ingredients = <String>[].obs;
  RxString servings = '1'.obs;
  RxString totalTime = '1'.obs;

  var categories = <FoodCategory>[].obs;
  RxBool isChanged = false.obs;
  RxBool isEdit = false.obs;

  NetworkService _networkService = NetworkService();

  Rx<File> image = Rx<File>();
  setData(Recipe recipe) async {
    if (categories.isEmpty) {
      categories.assignAll(
        (await _networkService.getCategories()),
      );
    }
    if (recipe != null) {
      foto = recipe.foto;
      idRecipe = recipe.idRecipe;
      isEdit.value = true;
      title.value = recipe.title;
      idCategory.value = recipe.idCategory;
      steps.assignAll(recipe.steps);
      ingredients.assignAll(recipe.ingredients);
      servings.value = recipe.servings;
      totalTime.value = recipe.totalTime;
    } else {
      title.value = '';
      idCategory.value = '1';
      steps.assignAll(
        <String>[],
      );
      ingredients.assignAll(
        <String>[],
      );
      servings.value = '1';
      totalTime.value = '1';
      isChanged.value = false;
      isEdit.value = false;
      image.value = null;
      idRecipe = null;
      foto = null;
    }
  }

  saveRecipe([String uid]) async {
    String action = isEdit.value ? "update" : "add";
    Recipe recipe = Recipe(
      idUser: uid,
      foto: foto,
      idRecipe: idRecipe,
      steps: steps,
      totalTime: totalTime.value,
      ingredients: ingredients,
      servings: servings.value,
      title: title.value,
      idCategory: idCategory.value,
    );
    Get.dialog(
      SimpleDialog(
        title: Text(
          '${isEdit.value?"Updating":"Adding"} your recipe....',
        ),
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              Text('loading'),
            ],
          ),
        ],
      ),
    );
    var result =
        await _networkService.addOrUpdateRecipe(recipe, foto: image.value);
    Get.back();
    Get.showSnackbar(
      GetBar(
        duration: Duration(seconds: 2),
        messageText: Text(
          result ?? false
              ? "sucesfully $action recipe"
              : " not success $action",
          style: TextStyle(color: ColorPallete.textWhite),
        ),
      ),
    );
    if (result ?? false) {
      Timer(
        Duration(milliseconds: 2250),
        () {
          Get.back<bool>(result: true);
        },
      );
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
