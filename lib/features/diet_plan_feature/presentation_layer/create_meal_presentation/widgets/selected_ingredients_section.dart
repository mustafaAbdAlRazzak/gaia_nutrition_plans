import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/core/constant/app_spaces.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/create_meal_controller.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/widgets/add_ingredient_button.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/widgets/selected_ingredient_item.dart';
import 'package:get/get.dart';

class SelectedIngredientsSection extends StatelessWidget {
  const SelectedIngredientsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Ingredients',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: smallSpace),
        GetBuilder<CreateMealController>(
          builder: (controller) => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.selectedFoods.length,
            itemBuilder: (context, index) => SelectedIngredientItem(
              selectedFood: controller.selectedFoods[index],
              onRemove: () => controller.removeFood(index),
              onEdit: () => controller.editFood(index),
              calories: controller.itemCalories(index),
              protein: controller.itemProtein(index),
              fat: controller.itemFat(index),
              carbohydrate: controller.itemCarbohydrate(index),
            ),
          ),
        ),
        const SizedBox(height: smallSpace),
        const AddIngredientButton(),
      ],
    );
  }
}
