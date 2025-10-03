import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_ingredient_entity.dart';

abstract class MealIngredientLocalDataSource {
  Future<int> createMealIngredient(MealIngredientEntity mealIngredient);
  Future<void> deleteMealIngredient(MealIngredientEntity mealIngredient);
  Future<void> updateMealIngredient(MealIngredientEntity mealIngredient);
  Future<String> getMealIngredientName(MealIngredientEntity mealIngredient);
  Future<double> getMealIngredientCalories(MealIngredientEntity mealIngredient);
  Future<double> getMealIngredientProtein(MealIngredientEntity mealIngredient);
  Future<double> getMealIngredientFat(MealIngredientEntity mealIngredient);
  Future<double> getMealIngredientCarbohydrate(
    MealIngredientEntity mealIngredient,
  );
}
