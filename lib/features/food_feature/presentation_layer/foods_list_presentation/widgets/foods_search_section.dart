import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/foods_list_controller.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/widgets/foods_search_field.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/widgets/saved_foods_toggle_button.dart';
import 'package:get/get.dart';

class FoodsSearchSection extends StatelessWidget {
  const FoodsSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodsListController>(
      builder: (controller) {
        return const Padding(
          padding: EdgeInsets.all(smallSpace),
          child: Row(
            children: [
              Expanded(child: FoodsSearchField()),
              SizedBox(width: mediumSpace),
              SavedFoodsToggleButton(),
            ],
          ),
        );
      },
    );
  }
}
