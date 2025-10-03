import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/models/local_models/sqflite_meal_model.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';

class SqfliteMealMapper {
  static MealEntity toEntity(SqfliteMealModel model) {
    return MealEntity(
      id: model.id,
      dietPlanId: model.dietPlanId,
      name: model.name,
      description: model.description,
    );
  }

  static SqfliteMealModel toModel(MealEntity entity) {
    return SqfliteMealModel(
      id: entity.id,
      dietPlanId: entity.dietPlanId!,
      name: entity.name,
      description: entity.description,
    );
  }
}
