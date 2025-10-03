import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/ai_diet_plan_generator/ai_diet_plan_generator_controller.dart';
import 'package:get/get.dart';

class MealsCountSelectionWidget extends StatelessWidget {
  const MealsCountSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AiDietPlanGeneratorController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How many meals per day do you prefer?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: mediumSpace),
            ...controller.mealsCountOptions.map((option) {
              return Container(
                margin: const EdgeInsets.only(bottom: smallSpace),
                child: RadioListTile<int>(
                  title: Text(option['label']!),
                  value: option['value']!,
                  groupValue: controller.selectedMealsCount,
                  onChanged: (value) => controller.updateMealsCount(value!),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}
