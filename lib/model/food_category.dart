import 'dart:convert';

List<FoodCategory> foodCategoryFromJson(String str) => List<FoodCategory>.from(json.decode(str).map((x) => FoodCategory.fromJson(x)));

String foodCategoryToJson(List<FoodCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodCategory {
    FoodCategory({
        this.idCategory,
        this.category,
    });

    String idCategory;
    String category;

    factory FoodCategory.fromJson(Map<String, dynamic> json) => FoodCategory(
        idCategory: json["id_category"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id_category": idCategory,
        "category": category,
    };
}
