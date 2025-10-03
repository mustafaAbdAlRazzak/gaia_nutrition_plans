import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/repositories_interfaces/food_repository_interface.dart';

class GetFoodFormLocalDataBaseByIdUseCase {
  final FoodRepositoryInterface foodRepositoryInterface;
  GetFoodFormLocalDataBaseByIdUseCase(this.foodRepositoryInterface);
  Future<FoodEntity> execute(int id) async {
    return await foodRepositoryInterface.getFoodFormLocalDataBaseById(id);
  }
}
