import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/ai_diet_plan_generator/ai_diet_plan_generator_controller.dart';
import 'package:get/get.dart';

class WorkoutDaysSelectionWidget extends StatelessWidget {
  const WorkoutDaysSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AiDietPlanGeneratorController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How many days do you workout per week?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: mediumSpace),
            ...controller.workoutDaysOptions.map((option) {
              return Container(
                margin: const EdgeInsets.only(bottom: smallSpace),
                child: RadioListTile<int>(
                  title: Text(option['label']!),
                  value: option['value']!,
                  groupValue: controller.selectedWorkoutDays,
                  onChanged: (value) => controller.updateWorkoutDays(value!),
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
