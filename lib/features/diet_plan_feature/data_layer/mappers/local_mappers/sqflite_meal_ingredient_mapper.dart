import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/models/local_models/sqflite_meal_ingredient_model.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_ingredient_entity.dart';

class SqfliteMealIngredientMapper {
  static MealIngredientEntity toEntity(SqfliteMealIngredientModel model) {
    return MealIngredientEntity(
      id: model.id,
      mealId: model.mealId,
      weight: model.weight,
      foodId: model.foodId,
    );
  }

  static SqfliteMealIngredientModel toModel(MealIngredientEntity entity) {
    return SqfliteMealIngredientModel(
      id: entity.id,
      mealId: entity.mealId!,
      weight: entity.weight,
      foodId: entity.foodId!,
    );
  }
}
