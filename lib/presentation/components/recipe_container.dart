import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saikai/constant/color_pallete.dart';
import 'package:saikai/model/recipe.dart';

class RecipeContainer extends StatelessWidget {
  final Recipe recipe;
  final String category;
  const RecipeContainer({Key key, this.recipe, this.category})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: Get.width / 5,
            width: Get.width / 5,
            color: Colors.white,
            child: recipe.isNull
                ? SizedBox()
                : Container(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.network(
                            recipe.urlPhoto,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Wrap(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              color: ColorPallete.mainBlue,
                              child: Text(
                                category,
                                style: TextStyle(
                                    color: ColorPallete.mainWhite, fontSize: 9),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recipe == null
                  ? <Widget>[
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: double.infinity,
                        height: 8.0,
                        color: Colors.white,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 8.0,
                        color: Colors.white,
                      ),
                    ]
                  : <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Text(recipe.title),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                      ),
                      Row(
                        children: [
                          Text(recipe.totalTime + " min"),
                          Icon(Icons.timer_outlined),
                        ],
                      ),
                    ],
            ),
          )
        ],
      ),
    );
  }
}
