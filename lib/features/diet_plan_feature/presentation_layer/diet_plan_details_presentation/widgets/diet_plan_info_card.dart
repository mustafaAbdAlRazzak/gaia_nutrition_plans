import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/diet_plan_entity.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/diet_plan_details_presentation/widgets/nutrient_item.dart';

class DietPlanInfoCard extends StatelessWidget {
  final DietPlanEntity dietPlan;
  final double totalCalories;
  final double totalProtein;
  final double totalFat;
  final double totalCarbohydrate;

  const DietPlanInfoCard({
    super.key,
    required this.dietPlan,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalFat,
    required this.totalCarbohydrate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          'Nutritional Information',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: mediumSpace),
        // Nutritional Grid
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NutrientItem(label: 'Calories', value: totalCalories, unit: 'kcal'),
            NutrientItem(label: 'Protein', value: totalProtein, unit: 'g'),
            NutrientItem(label: 'Fat', value: totalFat, unit: 'g'),
            NutrientItem(label: 'Carbs', value: totalCarbohydrate, unit: 'g'),
          ],
        ),
      ],
    );
  }
}
