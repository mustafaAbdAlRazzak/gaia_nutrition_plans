import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/save_diet_plan_presentation/save_diet_plan_controller.dart';
import 'package:get/get.dart';

class SaveDietPlanActions extends GetView<SaveDietPlanController> {
  const SaveDietPlanActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          onPressed: controller.onCancel,
          child: const Text('Cancel'),
        ),
        const SizedBox(width: smallSpace),
        ElevatedButton(
          onPressed: controller.isLoading ? null : controller.saveDietPlan,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
