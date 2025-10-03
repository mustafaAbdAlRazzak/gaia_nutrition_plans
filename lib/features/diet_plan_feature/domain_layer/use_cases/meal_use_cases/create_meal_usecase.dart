import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/meal_repository_interfaces.dart';

class CreateMealUseCase {
  final MealRepositoryInterface repository;

  CreateMealUseCase(this.repository);

  Future<int> execute(MealEntity meal) async {
    return await repository.createMeal(meal);
  }
}
