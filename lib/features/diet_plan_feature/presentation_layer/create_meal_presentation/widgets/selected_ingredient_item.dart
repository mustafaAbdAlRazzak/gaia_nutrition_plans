import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/create_meal_controller.dart';

class SelectedIngredientItem extends StatelessWidget {
  final SelectedFood selectedFood;
  final VoidCallback onRemove;
  final VoidCallback onEdit;
  final double calories, fat, protein, carbohydrate;

  const SelectedIngredientItem({
    super.key,
    required this.selectedFood,
    required this.onRemove,
    required this.onEdit,
    required this.calories,
    required this.protein,
    required this.carbohydrate,
    required this.fat,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(mediumSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Name Row
            Text(
              selectedFood.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: smallSpace),
            // Main Content Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Weight Input Column
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: selectedFood.weightController,
                        onChanged: (value) => onEdit(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                      const SizedBox(height: tinySpace),
                      Text(
                        "grams",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: smallSpace),
                // Nutrition Info Column
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      NutritionRow(
                        "Calories",
                        calories.toStringAsFixed(1),
                        "kcal",
                      ),
                      const Divider(),
                      NutritionRow("Protein", protein.toStringAsFixed(1), "g"),
                      const Divider(),
                      NutritionRow("Fat", fat.toStringAsFixed(1), "g"),
                      const Divider(),
                      NutritionRow(
                        "Carbs",
                        carbohydrate.toStringAsFixed(1),
                        "g",
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: smallSpace),
            ElevatedButton(onPressed: onRemove, child: const Text('Remove')),
          ],
        ),
      ),
    );
  }
}

class NutritionRow extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const NutritionRow(this.label, this.value, this.unit, {super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
        ),
        Text("$value $unit", style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
