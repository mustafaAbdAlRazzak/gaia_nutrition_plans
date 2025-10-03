import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_icon_sizes.dart';
import 'package:gaia_nutrition_plans/features/food_feature/presentation_layer/foods_list_presentation/foods_list_controller.dart';
import 'package:get/get.dart';

class FoodsSearchField extends StatelessWidget {
  const FoodsSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FoodsListController>(
      builder: (controller) {
        return TextField(
          controller: controller.searchController,
          onChanged: controller.onSearchChanged,
          decoration: const InputDecoration(
            hintText: 'Search foods...',
            prefixIcon: Icon(Icons.search, size: mediumIcon),
          ),
        );
      },
    );
  }
}
