import 'package:gaia_nutrition_plans/features/food_feature/data_layer/models/local_models/sqflite_models/food_sqflite_model.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';

class FoodSqfliteMapper {
  static FoodEntity toEntity(FoodSqfliteModel foodModel) {
    return FoodEntity(
      id: foodModel.id,
      name: foodModel.name,
      protein: foodModel.protein,
      fat: foodModel.fat,
      carbohydrate: foodModel.carbohydrate,
      calories: foodModel.calories,
    );
  }

  static FoodSqfliteModel toModel(FoodEntity foodEntity) {
    return FoodSqfliteModel(
      id: foodEntity.id,
      name: foodEntity.name,
      protein: foodEntity.protein,
      fat: foodEntity.fat,
      carbohydrate: foodEntity.carbohydrate,
      calories: foodEntity.calories,
    );
  }
}
