import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saikai/constant/color_pallete.dart';
import 'package:saikai/presentation/components/list_recipe_builder.dart';
import 'package:saikai/presentation/components/recipe_container.dart';
import 'package:saikai/presentation/controller/my_recipe_controller.dart';
import 'package:saikai/presentation/screens/add_edit_recipe.dart';
import 'package:shimmer/shimmer.dart';

class MyRecipe extends StatelessWidget {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  final MyRecipeController _myRecipeController = Get.put(MyRecipeController(),tag: "mrc");

  MyRecipe({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Obx(
          () => LiquidPullToRefresh(
            key: _refreshIndicatorKey,
            onRefresh: _myRecipeController.loadData,
            showChildOpacityTransition: false,
            child: Column(
              children: [
                Expanded(
                  child: _myRecipeController.isLoadingRecipes.value
                      ? Shimmer.fromColors(
                          enabled: true,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemBuilder: (_, __) => RecipeContainer(),
                              itemCount: 6,
                            ),
                          ),
                          baseColor: ColorPallete.mainWhite,
                          highlightColor: ColorPallete.mainGrey,
                        )
                      : (_myRecipeController.recipes?.length ?? 0) < 1
                          ? ListView(children: [
                              Center(
                                child: Text(
                                    'sorry you don\'t have any recipe yet'),
                              ),
                            ])
                          : ListRecipeBuilder(
                              editMode: true,
                              recipes: _myRecipeController.recipes,
                              categories: _myRecipeController.categories,
                            ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool isAdded = await Get.to(
            AddEditRecipe(),
          );
          if (isAdded ?? false) _myRecipeController.loadData();
        },
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}
