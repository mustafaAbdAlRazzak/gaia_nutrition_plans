import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_ingredient_entity.dart';

abstract class MealLocalDataSource {
  Future<int> createMeal(MealEntity meal);
  Future<void> updateMeal(MealEntity meal);
  Future<void> deleteMeal(MealEntity meal);
  Future<List<MealIngredientEntity>> getMealIngredients(MealEntity meal);
  Future<double> getMealProtein(MealEntity meal);
  Future<double> getMealCalories(MealEntity meal);
  Future<double> getMealFat(MealEntity meal);
  Future<double> getMealCarbohydrate(MealEntity meal);
}
