import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:saikai/constant/color_pallete.dart';
import 'package:saikai/presentation/components/list_recipe_builder.dart';
import 'package:saikai/presentation/components/recipe_container.dart';
import 'package:saikai/presentation/controller/main_controller.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatelessWidget {
  final MainController _mainController = Get.find(tag: "mc");
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () => LiquidPullToRefresh(
          key: _refreshIndicatorKey,
          onRefresh: _mainController.loadRecipes,
          springAnimationDurationInMilliseconds: 500,
          showChildOpacityTransition: false,
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 8,
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _mainController.categories.length,
                        itemBuilder: (ctx, index) => Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              onTap: () => _mainController.addFilter(
                                  _mainController.categories[index].idCategory),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorPallete.mainGrey,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text(_mainController
                                            .categories[index].category),
                                        AnimatedSwitcher(
                                          switchInCurve: Curves.easeIn,
                                          switchOutCurve: Curves.easeOut,
                                          duration: Duration(seconds: 1),
                                          transitionBuilder:
                                              (child, animation) =>
                                                  RotationTransition(
                                            turns: animation,
                                            child: child,
                                          ),
                                          child: _mainController.filter
                                                  .contains(_mainController
                                                      .categories[index]
                                                      .idCategory)
                                              ? Icon(Icons.close_rounded)
                                              : SizedBox(),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _mainController.isLoadingRecipes.value
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
                    : (_mainController.filteredRecipes?.length ?? 0) < 1
                        ? Center(
                            child: Card(
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      text: '😞\n',
                                      style: Get.textTheme.headline4,
                                      children: [
                                        TextSpan(
                                            text:
                                                ' sorry there is no recipe that matches what you are looking for',
                                            style: Get.textTheme.bodyText1)
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )),
                          )
                        : ListRecipeBuilder(
                            recipes: _mainController.filteredRecipes,
                            categories: _mainController.categories,
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
