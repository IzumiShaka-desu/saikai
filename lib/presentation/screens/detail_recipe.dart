import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saikai/constant/color_pallete.dart';
import 'package:saikai/model/recipe.dart';

class DetailRecipe extends StatefulWidget {
  DetailRecipe(this.recipe, this.category);
  final Recipe recipe;
  final String category;

  @override
  _DetailRecipeState createState() => _DetailRecipeState();
}

class _DetailRecipeState extends State<DetailRecipe> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              SizedBox(
                height: Get.height,
                width: Get.width,
                child: Container(
                  color: Get.theme.accentColor,
                  padding: EdgeInsets.only(top: Get.height / 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.recipe.title,
                                          style: Get.textTheme.headline4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          " ${widget.category}",
                                          style: Get.textTheme.subtitle1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.timer),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                          "${widget.recipe.totalTime} minutes"),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.width / 3,
                            width: Get.width / 3,
                            child: Image.network(
                              widget.recipe.urlPhoto,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                child: DraggableScrollableSheet(
                  initialChildSize: 0.4,
                  builder: (ctx, scrollController) => Container(
                    decoration: BoxDecoration(
                      color: Get.isDarkMode
                          ? Get.theme.backgroundColor
                          : ColorPallete.mainWhite,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(
                          30,
                        ),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView(
                                  controller: scrollController,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Get.width / 5),
                                      child: SizedBox(
                                        height: 5,
                                        child: Container(
                                          color: Get.isDarkMode
                                              ? ColorPallete.mainWhite
                                              : ColorPallete.deepGrey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 20,
                          child: Container(
                            width: Get.width,
                            child: DefaultTabController(
                              initialIndex: selectedIndex,
                              length: 2,
                              child: Container(
                                child: Column(
                                  children: [
                                    SizedBox(height:10),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TabBar(
                                            onTap: (index) {
                                              setState(() {
                                                selectedIndex = index;
                                              },);
                                            },
                                            tabs: [
                                              Tab(
                                                child: Text(
                                                  "Ingredients",
                                                  style: Get.isDarkMode
                                                      ? Get.textTheme.subtitle1
                                                      : Get.textTheme.subtitle1
                                                          .copyWith(
                                                              color: ColorPallete
                                                                  .textBlack),
                                                ),
                                              ),
                                              Tab(
                                                child: Text(
                                                  "Steps",
                                                  style: Get.isDarkMode
                                                      ? Get.textTheme.subtitle1
                                                      : Get.textTheme.subtitle1
                                                          .copyWith(
                                                          color: ColorPallete
                                                              .textBlack,
                                                        ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: selectedIndex == 0
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: widget
                                                  .recipe.ingredients.length,
                                              itemBuilder: (ctx, index) =>
                                                  ListTile(
                                                title: Text(
                                                    "- ${widget.recipe.ingredients[index]}."),
                                              ),
                                            )
                                          : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  widget.recipe.steps.length,
                                              itemBuilder: (ctx, index) =>
                                                  ListTile(
                                                title: Text(
                                                    "${index + 1}. ${widget.recipe.steps[index]}."),
                                              ),
                                            ),
                                    ),
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
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios_outlined),
                  onPressed: () => Get.back(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
