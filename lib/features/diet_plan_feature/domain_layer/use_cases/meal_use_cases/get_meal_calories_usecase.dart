import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/meal_repository_interfaces.dart';

class GetMealCaloriesUseCase {
  final MealRepositoryInterface repository;

  GetMealCaloriesUseCase(this.repository);

  Future<double> execute(MealEntity meal) async {
    return await repository.getMealCalories(meal);
  }
}
