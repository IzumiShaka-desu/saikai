import 'dart:convert';

import 'package:saikai/constant/util.dart';

List<Recipe> recipeFromJson(String str) =>
    List<Recipe>.from(json.decode(str).map((x) => Recipe.fromJson(x)));

String recipeToJson(List<Recipe> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Recipe {
  Recipe({
    this.idRecipe,
    this.idUser,
    this.dateCreated,
    this.title,
    this.idCategory,
    this.servings,
    this.totalTime,
    this.ingredients,
    this.steps,
    this.foto,
  });

  String idRecipe;
  String idUser;
  DateTime dateCreated;
  String title;
  String idCategory;
  String servings;
  String totalTime;
  List<String> ingredients;
  List<String> steps;
  String foto;
  static const BASEURLImage = 'http://192.168.43.150/images/';
  String get urlPhoto => (foto != null) ? BASEURLImage + foto : null;
  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        idRecipe: json["id_recipe"],
        idUser: json["id_user"],
        dateCreated: DateTime.parse(
          json["date_created"],
        ),
        title: json["title"],
        idCategory: json["id_category"],
        servings: json["servings"],
        totalTime: json["total_time"],
        ingredients: parseJsonToListString(
              json["ingredients"],
            ) ??
            [],
        steps: parseJsonToListString(
              json["steps"],
            ) ??
            [],
        foto: json["foto"],
      );
  factory Recipe.def(String idUser) => Recipe(
        idUser: idUser,
        servings: '1',
        totalTime: '',
        title: '',
        idCategory: '1',
        ingredients: [],
        steps: [],
      );
  Map<String, dynamic> toJson() => {
        "id_recipe": idRecipe,
        "id_user": idUser,
        "title": title,
        "id_category": idCategory,
        "servings": servings,
        "total_time": totalTime,
        "ingredients": jsonEncode(ingredients),
        "steps": jsonEncode(steps),
        "foto": foto,
      };
}
