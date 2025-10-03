import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/ai_diet_plan_generator/ai_diet_plan_generator_controller.dart';
import 'package:get/get.dart';

class GoalSelectionWidget extends StatelessWidget {
  const GoalSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AiDietPlanGeneratorController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What is your goal?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: mediumSpace),
            ...controller.goals.map((goal) {
              return Container(
                margin: const EdgeInsets.only(bottom: smallSpace),
                child: RadioListTile<String>(
                  title: Text(goal['label']!),
                  value: goal['value']!,
                  groupValue: controller.selectedGoal,
                  onChanged: (value) => controller.updateGoal(value!),
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
