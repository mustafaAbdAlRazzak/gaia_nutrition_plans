import 'package:gaia_nutrition_plans/features/food_feature/data_layer/models/remote_models/f_d_c_models/f_d_c_food_model.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';

class FDCFoodMapper {
  static FoodEntity toEntity(FDCFoodModel foodModel) => FoodEntity(
    id: foodModel.id,
    name: foodModel.name,
    protein: foodModel.protein,
    fat: foodModel.fat,
    carbohydrate: foodModel.carbohydrate,
    calories: foodModel.calories,
  );

  static FDCFoodModel toModel(FoodEntity foodEntity) => FDCFoodModel(
    id: foodEntity.id,
    name: foodEntity.name,
    protein: foodEntity.protein,
    fat: foodEntity.fat,
    carbohydrate: foodEntity.carbohydrate,
    calories: foodEntity.calories,
  );
}
