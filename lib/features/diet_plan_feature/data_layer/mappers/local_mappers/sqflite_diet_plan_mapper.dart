import 'package:gaia_nutrition_plans/features/diet_plan_feature/data_layer/models/local_models/sqflite_diet_plan_model.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';

class SqfliteDietPlanMapper {
  static DietPlanEntity toEntity(SqfliteDietPlanModel model) => DietPlanEntity(
    id: model.id,
    name: model.name,
    description: model.description,
  );
  static SqfliteDietPlanModel toModel(DietPlanEntity entity) =>
      SqfliteDietPlanModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
      );
}
