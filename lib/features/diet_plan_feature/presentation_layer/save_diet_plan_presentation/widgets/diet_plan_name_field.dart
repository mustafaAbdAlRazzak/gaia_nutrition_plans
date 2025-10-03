import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/save_diet_plan_presentation/save_diet_plan_controller.dart';
import 'package:get/get.dart';

class DietPlanNameField extends GetView<SaveDietPlanController> {
  const DietPlanNameField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallSpace),
      child: TextFormField(
        controller: controller.nameController,
        focusNode: controller.nameFocusNode,
        decoration: const InputDecoration(hintText: 'Diet Plan Name'),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a name';
          }
          return null;
        },
        onFieldSubmitted: controller.onNameFieldSubmitted,
      ),
    );
  }
}
