import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/data_sources/local_data_sources/abstract_local_data_sources/meal_local_data_source.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_ingredient_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/meal_repository_interfaces.dart';

class MealRepositoryImplementation implements MealRepositoryInterface {
  final MealLocalDataSource mealLocalDataSource;
  MealRepositoryImplementation(this.mealLocalDataSource);
  @override
  Future<int> createMeal(MealEntity meal) async {
    return await mealLocalDataSource.createMeal(meal);
  }

  @override
  Future<void> deleteMeal(MealEntity meal) async {
    await mealLocalDataSource.deleteMeal(meal);
  }

  @override
  Future<double> getMealCalories(MealEntity meal) async {
    return await mealLocalDataSource.getMealCalories(meal);
  }

  @override
  Future<double> getMealCarbohydrate(MealEntity meal) async {
    return await mealLocalDataSource.getMealCarbohydrate(meal);
  }

  @override
  Future<double> getMealFat(MealEntity meal) async {
    return await mealLocalDataSource.getMealFat(meal);
  }

  @override
  Future<List<MealIngredientEntity>> getMealIngredients(MealEntity meal) async {
    return await mealLocalDataSource.getMealIngredients(meal);
  }

  @override
  Future<double> getMealProtein(MealEntity meal) async {
    return await mealLocalDataSource.getMealProtein(meal);
  }

  @override
  Future<void> updateMeal(MealEntity meal) async {
    await mealLocalDataSource.updateMeal(meal);
  }
}
