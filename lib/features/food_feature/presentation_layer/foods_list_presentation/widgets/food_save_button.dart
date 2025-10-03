import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_icon_sizes.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/foods_list_controller.dart';
import 'package:get/get.dart';

class FoodSaveButton extends StatelessWidget {
  final FoodEntity food;
  final bool showSavedFoods;
  final bool isSaved;

  const FoodSaveButton({
    super.key,
    required this.food,
    required this.showSavedFoods,
    required this.isSaved,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodsListController>(
      builder: (controller) {
        return IconButton(
          onPressed: () {
            if (showSavedFoods) {
              controller.unsaveFood(food);
            } else if (isSaved) {
              controller.unsaveFood(food);
            } else {
              controller.saveFood(food);
            }
          },
          icon: Icon(
            showSavedFoods
                ? Icons.delete
                : isSaved
                ? Icons.bookmark
                : Icons.bookmark_border,
            size: mediumIcon,
          ),
        );
      },
    );
  }
}
