import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/ai_diet_plan_generator/ai_diet_plan_generator_controller.dart';
import 'package:get/get.dart';

class DietaryRestrictionsSelectionWidget extends StatelessWidget {
  const DietaryRestrictionsSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AiDietPlanGeneratorController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Do you have any dietary restrictions?'),
            const SizedBox(height: mediumSpace),
            ...controller.dietaryRestrictions.map((restriction) {
              return Container(
                margin: const EdgeInsets.only(bottom: smallSpace),
                child: RadioListTile<String>(
                  title: Text(restriction['label']!),
                  value: restriction['value']!,
                  groupValue: controller.selectedDietaryRestrictions,
                  onChanged: (value) =>
                      controller.updateDietaryRestrictions(value!),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
