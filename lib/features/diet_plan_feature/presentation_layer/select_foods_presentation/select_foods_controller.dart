import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/get_foods_use_case.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class SelectFoodsController extends GetxController {
  late final GetFoodsUseCase getFoodsUseCase;
  final TextEditingController searchController = TextEditingController();
  SelectFoodsController({required this.getFoodsUseCase});
  List<FoodEntity> searchResults = [];
  int currentPage = 1;
  final int pageSize = 20;
  Map<int, FoodEntity> selectedFoods = {};
  late final PagingController<int, FoodEntity> pagingController;

  @override
  void onInit() {
    super.onInit();
    pagingController = PagingController<int, FoodEntity>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (int pageKey) => _fetchPage(pageKey),
    );
  }

  Future<List<FoodEntity>> _fetchPage(int pageKey) async {
    currentPage = pageKey;
    return await getFoodsUseCase.execute(
      searchQuery: searchController.text,
      pageNumber: pageKey,
      pageSize: pageSize,
    );
  }

  void onSearchChanged(String value) {
    currentPage = 1;
    pagingController.refresh();
  }

  @override
  void onClose() {
    searchController.dispose();
    pagingController.dispose();
    super.onClose();
  }

  void addFood(FoodEntity food) {
    selectedFoods[food.id!] = food;
    update();
  }

  void removeFood(int foodId) {
    selectedFoods.remove(foodId);
    update();
  }

  bool isFoodSelected(int foodId) {
    return selectedFoods.containsKey(foodId);
  }

  void whenSelectedFoodPressed(FoodEntity food) {
    if (isFoodSelected(food.id!)) {
      removeFood(food.id!);
    } else {
      addFood(food);
    }
  }

  void onCancel() {
    Get.back(result: <FoodEntity>[]);
  }

  void onAddSelectedFoods() {
    Get.back(result: selectedFoods.values.toList());
  }
}
