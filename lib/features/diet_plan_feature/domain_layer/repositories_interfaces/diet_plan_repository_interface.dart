import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';

abstract class DietPlanRepositoryInterface {
  Future<List<DietPlanEntity>> getDietPlans({
    required String searchQuery,
    required int pageNumber,
    required int pageSize,
  });
  Future<int> createDietPlan(DietPlanEntity dietPlan);
  Future<Map<String, dynamic>> getDietPlanFromAi(String prompt);
  Future<void> updateDietPlan(DietPlanEntity dietPlan);
  Future<void> deleteDietPlan(DietPlanEntity dietPlan);
  Future<List<MealEntity>> getDietPlanMeal(DietPlanEntity dietPlan);
  Future<double> getTotalProtein(DietPlanEntity dietPlan);
  Future<double> getTotalFat(DietPlanEntity dietPlan);
  Future<double> getTotalCarbohydrate(DietPlanEntity dietPlan);
  Future<double> getTotalCalories(DietPlanEntity dietPlan);
}
