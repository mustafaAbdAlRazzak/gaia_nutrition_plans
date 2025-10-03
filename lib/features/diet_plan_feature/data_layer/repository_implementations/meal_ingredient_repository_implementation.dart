import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/meal_ingredient_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_ingredient_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/meal_ingredient_repository_interface.dart';

class MealIngredientRepositoryImplementation
    implements MealIngredientRepositoryInterface {
  final MealIngredientLocalDataSource mealIngredientLocalDataSource;
  MealIngredientRepositoryImplementation(this.mealIngredientLocalDataSource);
  @override
  Future<int> createMealIngredient(MealIngredientEntity mealIngredient) async {
    return await mealIngredientLocalDataSource.createMealIngredient(
      mealIngredient,
    );
  }

  @override
  Future<void> deleteMealIngredient(MealIngredientEntity mealIngredient) async {
    await mealIngredientLocalDataSource.deleteMealIngredient(mealIngredient);
  }

  @override
  Future<double> getMealIngredientCalories(
    MealIngredientEntity mealIngredient,
  ) async {
    return await mealIngredientLocalDataSource.getMealIngredientCalories(
      mealIngredient,
    );
  }

  @override
  Future<double> getMealIngredientCarbohydrate(
    MealIngredientEntity mealIngredient,
  ) async {
    return await mealIngredientLocalDataSource.getMealIngredientCarbohydrate(
      mealIngredient,
    );
  }

  @override
  Future<double> getMealIngredientFat(
    MealIngredientEntity mealIngredient,
  ) async {
    return await mealIngredientLocalDataSource.getMealIngredientFat(
      mealIngredient,
    );
  }

  @override
  Future<String> getMealIngredientName(
    MealIngredientEntity mealIngredient,
  ) async {
    return await mealIngredientLocalDataSource.getMealIngredientName(
      mealIngredient,
    );
  }

  @override
  Future<double> getMealIngredientProtein(
    MealIngredientEntity mealIngredient,
  ) async {
    return await mealIngredientLocalDataSource.getMealIngredientProtein(
      mealIngredient,
    );
  }

  @override
  Future<void> updateMealIngredient(MealIngredientEntity mealIngredient) async {
    await mealIngredientLocalDataSource.updateMealIngredient(mealIngredient);
  }
}
