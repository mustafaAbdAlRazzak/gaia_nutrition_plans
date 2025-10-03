import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';

abstract class FoodRemoteDataSources {
  Future<List<FoodEntity>> getFoods({
    String? searchQuery,
    required int pageNumber,
    required int pageSize,
  });
}
