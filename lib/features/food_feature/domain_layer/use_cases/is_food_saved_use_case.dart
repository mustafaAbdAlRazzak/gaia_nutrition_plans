import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/repositories_interfaces/food_repository_interface.dart';

class IsFoodSavedUseCase {
  final FoodRepositoryInterface foodRepositoryInterface;
  IsFoodSavedUseCase(this.foodRepositoryInterface);
  Future<bool> execute(FoodEntity food) async {
    return await foodRepositoryInterface.isFoodSaved(food);
  }
}
