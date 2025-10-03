import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_ingredient_entity.dart';

class MealIngredientCohereModel {
  final double weight;

  MealIngredientCohereModel({required this.weight});

  factory MealIngredientCohereModel.fromMap(Map<String, dynamic> map) {
    return MealIngredientCohereModel(weight: (map['weight'] as num).toDouble());
  }

  MealIngredientEntity toEntity() {
    return MealIngredientEntity(weight: weight);
  }
}
