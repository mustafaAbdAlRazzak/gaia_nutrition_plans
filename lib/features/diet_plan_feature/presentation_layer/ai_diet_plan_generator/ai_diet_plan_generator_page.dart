import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/ai_diet_plan_generator/ai_diet_plan_generator_controller.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/ai_diet_plan_generator/widgets/dietary_restrictions_selection_widget.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/ai_diet_plan_generator/widgets/goal_selection_widget.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/ai_diet_plan_generator/widgets/meals_count_selection_widget.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/ai_diet_plan_generator/widgets/workout_days_selection_widget.dart';
import 'package:get/get.dart';

class AiDietPlanGeneratorPage extends StatelessWidget {
  const AiDietPlanGeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Diet Plan Generator'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(result: false),
        ),
      ),
      body: GetBuilder<AiDietPlanGeneratorController>(
        builder: (controller) {
          if (controller.isGenerating) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: largeSpace),
                  Text(
                    'Creating your personalized diet plan...',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(largeSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: mediumSpace),
                // Goal Section
                const GoalSelectionWidget(),
                const SizedBox(height: largeSpace),
                // Workout Days Section
                const WorkoutDaysSelectionWidget(),
                const SizedBox(height: largeSpace),
                // Meals Count Section
                const MealsCountSelectionWidget(),
                const SizedBox(height: largeSpace),
                // Dietary Restrictions Section
                const DietaryRestrictionsSelectionWidget(),
                const SizedBox(height: largeSpace),
                // Generate Button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.generateDietPlan,
                    child: const Text('Generate Diet Plan'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
