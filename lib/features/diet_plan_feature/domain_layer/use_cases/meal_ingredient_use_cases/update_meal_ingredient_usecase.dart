import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_ingredient_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/meal_ingredient_repository_interface.dart';

class UpdateMealIngredientUseCase {
  final MealIngredientRepositoryInterface repository;

  UpdateMealIngredientUseCase(this.repository);

  Future<void> execute(MealIngredientEntity mealIngredient) async {
    return await repository.updateMealIngredient(mealIngredient);
  }
}
