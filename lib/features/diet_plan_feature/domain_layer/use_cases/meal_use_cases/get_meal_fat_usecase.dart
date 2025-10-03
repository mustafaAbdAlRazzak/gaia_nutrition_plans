import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/meal_repository_interfaces.dart';

class GetMealFatUseCase {
  final MealRepositoryInterface repository;

  GetMealFatUseCase(this.repository);

  Future<double> execute(MealEntity meal) async {
    return await repository.getMealFat(meal);
  }
}
