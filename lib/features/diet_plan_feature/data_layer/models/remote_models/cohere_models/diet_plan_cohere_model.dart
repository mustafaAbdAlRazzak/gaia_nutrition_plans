import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';

class DietPlanCohereModel {
  final String name;
  final String description;

  DietPlanCohereModel({required this.name, required this.description});

  factory DietPlanCohereModel.fromMap(Map<String, dynamic> map) {
    return DietPlanCohereModel(
      name: map['name'],
      description: map['description'],
    );
  }
  DietPlanEntity toEntity() {
    return DietPlanEntity(name: name, description: description);
  }
}
