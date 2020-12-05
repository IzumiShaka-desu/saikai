import 'package:get/get.dart';
import 'package:saikai/model/food_category.dart';
import 'package:saikai/model/recipe.dart';
import 'package:saikai/service/network_service.dart';
import 'package:saikai/service/spref_service.dart';

class MyRecipeController extends GetxController {
  var recipes = <Recipe>[].obs;
  var categories = <FoodCategory>[].obs;
  RxBool isLoadingRecipes = false.obs;
  final NetworkService _networkService = NetworkService();
  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  Future<void> loadData() async {
    isLoadingRecipes.value = true;
    try {
      var result = await Future.wait(
        [
          _networkService.getRecipes(),
          _networkService.getCategories(),
        ],
      );
      String idUser =
          (await SPrefService().getLoginDetails())['idUser'].toString();
      List<Recipe> myRecipe = (result[0] as List<Recipe>)
        ..removeWhere((element) => element.idUser != idUser);

      recipes = myRecipe.obs;
      categories = (result[1] as List<FoodCategory>).obs;
    } catch (e) {
      printError(
        info: e.toString(),
      );
    }
    isLoadingRecipes.value = false;
  }
}
