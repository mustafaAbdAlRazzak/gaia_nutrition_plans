import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/diet_plan_repository_interface.dart';

class GetDietPlanMealUseCase {
  final DietPlanRepositoryInterface repository;
  GetDietPlanMealUseCase(this.repository);
  Future<List<MealEntity>> execute(DietPlanEntity dietPlan) async {
    return await repository.getDietPlanMeal(dietPlan);
  }
}
