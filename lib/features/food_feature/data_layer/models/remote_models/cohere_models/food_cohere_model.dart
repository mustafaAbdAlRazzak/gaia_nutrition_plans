import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';

class FoodCohereModel {
  final String name;
  final double protein;
  final double fat;
  final double carbohydrate;
  final double calories;

  FoodCohereModel({
    required this.name,
    required this.protein,
    required this.fat,
    required this.carbohydrate,
    required this.calories,
  });

  factory FoodCohereModel.fromMap(Map<String, dynamic> map) {
    return FoodCohereModel(
      name: map['name'],
      protein: (map['protein'] as num).toDouble(),
      fat: (map['fat'] as num).toDouble(),
      carbohydrate: (map['carbohydrate'] as num).toDouble(),
      calories: (map['calories'] as num).toDouble(),
    );
  }

  FoodEntity toEntity() {
    return FoodEntity(
      name: name,
      protein: protein,
      fat: fat,
      carbohydrate: carbohydrate,
      calories: calories,
    );
  }
}
