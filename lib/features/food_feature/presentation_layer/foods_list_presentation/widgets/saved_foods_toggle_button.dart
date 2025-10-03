import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_icon_sizes.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/foods_list_controller.dart';
import 'package:get/get.dart';

class SavedFoodsToggleButton extends StatelessWidget {
  const SavedFoodsToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodsListController>(
      builder: (controller) {
        return IconButton(
          onPressed: controller.toggleFoodsView,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(mediumSpace),
          ),
          icon: Icon(
            controller.showSavedFoods ? Icons.list : Icons.bookmark,
            size: mediumIcon,
          ),
        );
      },
    );
  }
}
