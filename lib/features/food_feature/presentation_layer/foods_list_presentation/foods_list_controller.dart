import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/get_foods_use_case.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/get_saved_foods_use_case.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/is_food_saved_use_case.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/save_food_use_case.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/use_cases/unsave_food_use_case.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FoodsListController extends GetxController {
  final GetFoodsUseCase getFoodsUseCase;
  final GetSavedFoodsUseCase getSavedFoodsUseCase;
  final IsFoodSavedUseCase isFoodSavedUseCase;
  final SaveFoodUseCase saveFoodUseCase;
  final UnsaveFoodUseCase unsaveFoodUseCase;
  FoodsListController({
    required this.getFoodsUseCase,
    required this.getSavedFoodsUseCase,
    required this.saveFoodUseCase,
    required this.unsaveFoodUseCase,
    required this.isFoodSavedUseCase,
  });

  final TextEditingController searchController = TextEditingController();
  late final PagingController<int, FoodEntity> pagingController;
  List<int> savedFoodsId = [];
  bool showSavedFoods = false;
  int currentPage = 1;
  int pageSize = 20;

  @override
  void onInit() {
    super.onInit();
    _setupScrollController();
  }

  @override
  void onClose() {
    searchController.dispose();
    pagingController.dispose();
    super.onClose();
  }

  void _setupScrollController() {
    pagingController = PagingController<int, FoodEntity>(
      getNextPageKey: (state) =>
          state.lastPageIsEmpty ? null : state.nextIntPageKey,
      fetchPage: (int pageKey) => _fetchPage(pageKey),
    );
  }

  Future<List<FoodEntity>> _fetchPage(int pageKey) async {
    currentPage = pageKey;
    if (showSavedFoods) {
      final List<FoodEntity> results = await getSavedFoodsUseCase.execute(
        searchQuery: searchController.text.trim(),
        pageNumber: pageKey,
        pageSize: pageSize,
      );
      return results;
    } else {
      final List<FoodEntity> results = await getFoodsUseCase.execute(
        searchQuery: searchController.text.trim(),
        pageNumber: pageKey,
        pageSize: pageSize,
      );
      savedFoodsId.clear();
      for (FoodEntity element in results) {
        if (await isFoodSavedUseCase.execute(element)) {
          savedFoodsId.add(element.id!);
        }
      }
      return results;
    }
  }

  void toggleFoodsView() {
    showSavedFoods = !showSavedFoods;
    currentPage = 1;
    pagingController.refresh();
    update();
  }

  void onSearchChanged(String query) {
    currentPage = 1;
    pagingController.refresh();
  }

  Future<void> saveFood(FoodEntity food) async {
    try {
      savedFoodsId.add(food.id!);
      update();
      await saveFoodUseCase.execute(food);
    } catch (e) {
      Get.snackbar('Error', 'Failed to save food');
    }
  }

  Future<void> unsaveFood(FoodEntity food) async {
    try {
      savedFoodsId.remove(food.id!);
      update();
      await unsaveFoodUseCase.execute(food);
      pagingController.refresh();
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove food from saved');
    }
  }

  bool isFoodSaved(FoodEntity food) => savedFoodsId.contains(food.id);
}
