import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';

abstract class FoodLocalDataSources {
  Future<int> saveFood(FoodEntity food);
  Future<void> unsaveFood(FoodEntity food);
  Future<List<FoodEntity>> getSavedFoods({
    String? searchQuery,
    required int pageNumber,
    required int pageSize,
  });
  Future<bool> isFoodSaved(FoodEntity food);
  Future<FoodEntity> getFoodFormLocalDataBaseById(int id);
}
