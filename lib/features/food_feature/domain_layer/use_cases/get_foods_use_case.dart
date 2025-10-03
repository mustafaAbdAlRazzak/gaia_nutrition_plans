import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/repositories_interfaces/food_repository_interface.dart';

class GetFoodsUseCase {
  final FoodRepositoryInterface foodRepositoryInterface;
  GetFoodsUseCase(this.foodRepositoryInterface);
  Future<List<FoodEntity>> execute({
    required String searchQuery,
    required int pageNumber,
    required int pageSize,
  }) async {
    return await foodRepositoryInterface.getFoods(
      searchQuery: searchQuery,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
