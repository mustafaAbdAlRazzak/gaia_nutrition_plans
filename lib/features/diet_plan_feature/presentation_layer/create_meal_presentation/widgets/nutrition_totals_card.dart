import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/create_meal_controller.dart';
import 'package:get/get.dart';

class NutritionTotalsCard extends StatelessWidget {
  const NutritionTotalsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nutrition Totals', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: smallSpace),
        GetBuilder<CreateMealController>(
          builder: (controller) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NutritionItem(
                label: 'Calories',
                value: controller.totalCalories,
                unit: 'kcal',
              ),
              NutritionItem(
                label: 'Protein',
                value: controller.totalProtein,
                unit: 'g',
              ),
              NutritionItem(
                label: 'Fat',
                value: controller.totalFat,
                unit: 'g',
              ),
              NutritionItem(
                label: 'Carbs',
                value: controller.totalCarbohydrate,
                unit: 'g',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class NutritionItem extends StatelessWidget {
  final String label;
  final double value;
  final String unit;

  const NutritionItem({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: tinySpace),
        Text(
          '${value.toStringAsFixed(1)} $unit',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
