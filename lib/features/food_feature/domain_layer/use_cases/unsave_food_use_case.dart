import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/repositories_interfaces/food_repository_interface.dart';

class UnsaveFoodUseCase {
  final FoodRepositoryInterface foodRepositoryInterface;
  UnsaveFoodUseCase(this.foodRepositoryInterface);
  Future<void> execute(FoodEntity food) async {
    await foodRepositoryInterface.unsaveFood(food);
  }
}
