import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_ingredient_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/repositories_interfaces/meal_ingredient_repository_interface.dart';

class GetMealIngredientNameUseCase {
  final MealIngredientRepositoryInterface repository;

  GetMealIngredientNameUseCase(this.repository);

  Future<String> execute(MealIngredientEntity mealIngredient) async {
    return await repository.getMealIngredientName(mealIngredient);
  }
}
