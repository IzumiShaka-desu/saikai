import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saikai/constant/color_pallete.dart';
import 'package:saikai/model/food_category.dart';
import 'package:saikai/model/recipe.dart';
import 'package:saikai/presentation/components/recipe_container.dart';
import 'package:saikai/presentation/controller/my_recipe_controller.dart';
import 'package:saikai/presentation/screens/add_edit_recipe.dart';
import 'package:saikai/presentation/screens/detail_recipe.dart';
import 'package:saikai/service/network_service.dart';

class ListRecipeBuilder extends StatelessWidget {
  const ListRecipeBuilder({
    Key key,
    @required List<Recipe> recipes,
    @required List<FoodCategory> categories,
    bool editMode = false,
  })  : _recipes = recipes,
        _categories = categories,
        _editMode = editMode,
        super(key: key);

  final List<Recipe> _recipes;
  final bool _editMode;
  final List<FoodCategory> _categories;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemBuilder: (context, index) => Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => Get.to(
              DetailRecipe(
                  _recipes[index],
                  _categories
                      .firstWhere(
                        (element) =>
                            element.idCategory == _recipes[index].idCategory,
                      )
                      .category),
            ),
            child: Container(
              child: Column(
                children: [
                  if (_editMode)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit_outlined),
                          onPressed: () {
                            Get.to(
                              AddEditRecipe(
                                recipe: _recipes[index],
                              ),
                            );
                          },
                          color: ColorPallete.mainOrange,
                        ),
                        IconButton(
                          icon: Icon(Icons.delete_outline),
                          onPressed: () async {
                            MyRecipeController mRecipeCotroller = Get.find(tag: "mrc");
                            bool willDelete = await Get.dialog(
                              AlertDialog(
                                title: Text('Warning'),
                                content: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          'are you sure want to delete this item'),
                                    ),
                                  ],
                                ),
                                actions: [
                                  FlatButton(
                                    onPressed: () {
                                      Get.back<bool>(result: true);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                          color: ColorPallete.textWhite),
                                    ),
                                    color: ColorPallete.mainBlue,
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Get.back<bool>(result: false);
                                    },
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                        color: ColorPallete.textWhite,
                                      ),
                                    ),
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            );
                            if (willDelete) {
                              Timer timer = Timer(
                                Duration(seconds: 3),
                                () async {
                                  bool isDeleted = await NetworkService()
                                      .deleteRecipe(_recipes[index].idRecipe);
                                  Get.showSnackbar(
                                    GetBar(
                                      duration: Duration(seconds: 2),
                                      messageText: Text(
                                        (isDeleted)
                                            ? "delete item success"
                                            : "delete item not success",
                                        style: TextStyle(
                                            color: ColorPallete.mainWhite),
                                      ),
                                    ),
                                  );

                                  mRecipeCotroller.loadData();
                                },
                              );
                              Get.showSnackbar(
                                GetBar(
                                  duration: Duration(seconds: 3),
                                  messageText: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'deleting item...',
                                        style: TextStyle(
                                            color: ColorPallete.textWhite),
                                      ),
                                      FlatButton(
                                        color: ColorPallete.mainBlue,
                                        onPressed: () => timer.cancel(),
                                        child: Text('undo'),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  RecipeContainer(
                    recipe: _recipes[index],
                    category: _categories
                        .firstWhere((element) =>
                            element.idCategory == _recipes[index].idCategory)
                        .category,
                  ),
                ],
              ),
            ),
          ),
        ),
        itemCount: _recipes.length,
      ),
    );
  }
}
