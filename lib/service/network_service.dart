import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart' as httpParser;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:saikai/model/food_category.dart';
import 'package:saikai/model/profile.dart';
import 'package:saikai/model/recipe.dart';

abstract class BaseService {
  Future<List<Recipe>> getRecipes();
  Future<Map> login(String email, String password);
  Future<Map> register(String email, String password);
  Future<bool> updateProfil(Profile profile);
  Future<Profile> getProfile(int idUser);
  Future<bool> addOrUpdateRecipe(Recipe recipe, {File foto});
  Future<bool> deleteRecipe(String id);
  Future<List<FoodCategory>> getCategories();
}

class NetworkService extends BaseService {
  static const String BASEURL = "http://192.168.43.150/";
  static const String RECIPEPATH = "recipes/";
  static const String CATEGORIESPATH = "category/";
  static const String LOGINPATH = "auth/login";
  static const String REGISTERPATH = "auth/register";
  static const int TIMEOUT = 10000;

  final dio = Dio(
    BaseOptions(
      baseUrl: BASEURL,
      connectTimeout: TIMEOUT,
      receiveTimeout: TIMEOUT,
    ),
  );

  @override
  Future<List<Recipe>> getRecipes() async {
    String path = RECIPEPATH;
    List<Recipe> data = [];
    var response = await dio.get(path);
    if (response.statusCode == 200) {
      if (response.data != null) {
        return compute(recipeFromJson, jsonEncode(response.data));
      }
    }
    return data;
  }

  @override
  Future<Map> login(String email, String password) async {
    var data = {"email": email, "password": password};
    var result = {'result': false, 'message': 'login gagal'};
    String path = LOGINPATH;
    var response = await dio.post(path, data: FormData.fromMap(data));
    if (response.statusCode == 200) {
      Map json = response.data;
      if (json != null) {
        result = json['data'];
      }
    }

    return result;
  }

  @override
  Future<Map> register(String email, String password) async {
    var data = {"email": email, "password": password};
    var result = {"result": false, "message": "register gagal"};
    String path = REGISTERPATH;
    var response = await dio.post(path, data: FormData.fromMap(data));
    if (response.statusCode == 200) {
      Map json = response.data;
      result = json['data'];
    }
    return result;
  }

  @override
  Future<bool> updateProfil(Profile profile) async {
    if (profile.idUser != null) {
      Map<String, String> json = (profile.toJson()
        ..removeWhere((key, value) => value == null || value is! String));

      String path = "user/${profile.idUser}/profile/edit";

      var response = await dio.post(path, data: FormData.fromMap(json));
      if (response.statusCode == 200) {
        var json = response.data;
        return !json['error'];
      }
    }
    return false;
  }

  @override
  Future<Profile> getProfile(int idUser) async {
    Profile result = Profile();
    String path = "user/$idUser/profile";
    try {
      var response = await dio.get(path);
      if (response.statusCode == 200) {
        var json = response.data;
        result = Profile.fromJson(json);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return result;
  }

  @override
  Future<bool> addOrUpdateRecipe(Recipe recipe, {File foto}) async {
    String endpoint = RECIPEPATH;
    if (recipe.idRecipe != null) {
      endpoint += '${recipe.idRecipe}/update';
    } else {
      endpoint += "create";
    }
    try {
      Map<String, dynamic> recipeData = recipe.toJson();

      recipeData.removeWhere((key, value) => value == null);

      FormData data = FormData.fromMap(recipeData);
      if (foto != null) {
        data.files.add(
          MapEntry(
            'image',
            (await MultipartFile.fromFile(
              foto.path,
              contentType: httpParser.MediaType('images', 'jpg'),
            )),
          ),
        );
      }

      var response = await dio.post(
        endpoint,
        data: data,
      );
      return (!response?.data['error']) ?? false;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  @override
  Future<bool> deleteRecipe(String id) async {
    try {
      String path = "$RECIPEPATH$id/delete";
      var response = await dio.delete(path);
      return (!response?.data['error']) ?? false;
    } catch (e) {
      debugPrint(e.toString());
    }
    return false;
  }

  @override
  Future<List<FoodCategory>> getCategories() async {
    String path = CATEGORIESPATH;
    List<FoodCategory> data = [];
    var response = await dio.get(path);
    if (response.statusCode == 200) {
      if (response.data != null) {
        return foodCategoryFromJson(jsonEncode(response.data));
      }
    }
    return data;
  }
}
