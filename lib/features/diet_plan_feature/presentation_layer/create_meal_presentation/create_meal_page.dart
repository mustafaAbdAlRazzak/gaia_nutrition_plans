import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/create_meal_controller.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/widgets/meal_info_section.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/widgets/nutrition_totals_card.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/widgets/selected_ingredients_section.dart';
import 'package:get/get.dart';

class CreateMealPage extends GetView<CreateMealController> {
  const CreateMealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.isEditMode() ? 'Edit Meal' : 'Create Meal'),
        leading: IconButton(
          onPressed: controller.onCancle,
          icon: const Icon(Icons.close),
        ),
        actions: [
          ElevatedButton(
            onPressed: controller.saveMeal,
            child: const Text('Save Meal'),
          ),
          const SizedBox(width: mediumSpace),
        ],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(mediumSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MealInfoSection(),
            SizedBox(height: smallSpace),
            SelectedIngredientsSection(),
            SizedBox(height: smallSpace),
            NutritionTotalsCard(),
          ],
        ),
      ),
    );
  }
}
