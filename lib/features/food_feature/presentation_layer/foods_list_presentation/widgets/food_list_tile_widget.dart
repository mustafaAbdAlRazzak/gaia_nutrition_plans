import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/foods_list_controller.dart';
import 'package:gaia_nutrition_plans/shared_widgets/food_nutrition_info.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/widgets/food_save_button.dart';
import 'package:get/get.dart';

class FoodListTileWidget extends StatelessWidget {
  final FoodEntity food;
  const FoodListTileWidget({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodsListController>(
      builder: (controller) {
        return ListTile(
          title: Text(food.name),
          subtitle: FoodNutritionInfo(
            calories: food.calories,
            protein: food.protein,
            fat: food.fat,
            carbohydrate: food.carbohydrate,
          ),
          trailing: FoodSaveButton(
            food: food,
            showSavedFoods: controller.showSavedFoods,
            isSaved: controller.isFoodSaved(food),
          ),
        );
      },
    );
  }
}
