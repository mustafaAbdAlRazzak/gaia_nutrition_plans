import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plan_details_presentation/diet_plan_details_controller.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plan_details_presentation/widgets/add_meal_button.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plan_details_presentation/widgets/diet_plan_info_card.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plan_details_presentation/widgets/meals_list.dart';
import 'package:get/get.dart';

class DietPlanDetailsView extends GetView<DietPlanDetailsController> {
  const DietPlanDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.dietPlan.name)),
      body: GetBuilder<DietPlanDetailsController>(
        builder: (controller) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(smallSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DietPlanInfoCard(
                  dietPlan: controller.dietPlan,
                  totalCalories: controller.totalCalories,
                  totalProtein: controller.totalProtein,
                  totalFat: controller.totalFat,
                  totalCarbohydrate: controller.totalCarbohydrate,
                ),
                const SizedBox(height: mediumSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Meals',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    AddMealButton(onPressed: controller.addMeal),
                  ],
                ),
                const SizedBox(height: smallSpace),
                MealsList(
                  meals: controller.meals,
                  onEditMeal: controller.editMeal,
                  onDeleteMeal: controller.deleteMeal,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
