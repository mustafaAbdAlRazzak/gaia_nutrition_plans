import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';

class MealCohereModel {
  final String name;
  final String description;

  MealCohereModel({required this.name, required this.description});

  factory MealCohereModel.fromMap(Map<String, dynamic> map) {
    return MealCohereModel(name: map['name'], description: map['description']);
  }

  MealEntity toEntity() {
    return MealEntity(name: name, description: description);
  }
}
