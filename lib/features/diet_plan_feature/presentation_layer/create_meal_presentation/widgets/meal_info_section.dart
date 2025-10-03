import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/create_meal_controller.dart';
import 'package:get/get.dart';

class MealInfoSection extends GetView<CreateMealController> {
  const MealInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Meal Information', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: mediumSpace),
        TextFormField(
          controller: controller.nameController,
          decoration: const InputDecoration(hintText: 'Enter meal name'),
          textInputAction: TextInputAction.next,
          onChanged: (value) => controller.update(),
        ),
        const SizedBox(height: mediumSpace),
        TextFormField(
          controller: controller.descriptionController,
          decoration: const InputDecoration(hintText: 'Enter meal description'),
          textInputAction: TextInputAction.done,
          minLines: 1,
          maxLines: null,
        ),
      ],
    );
  }
}
