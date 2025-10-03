import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/save_diet_plan_presentation/save_diet_plan_controller.dart';
import 'package:get/get.dart';

class DietPlanDescriptionField extends GetView<SaveDietPlanController> {
  const DietPlanDescriptionField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallSpace),
      child: TextFormField(
        controller: controller.descriptionController,
        focusNode: controller.descriptionFocusNode,
        maxLines: 3,
        decoration: const InputDecoration(hintText: 'Description'),
      ),
    );
  }
}
