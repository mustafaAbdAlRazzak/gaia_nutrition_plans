import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/presentation_layer/create_meal_presentation/create_meal_controller.dart';
import 'package:get/get.dart';

class AddIngredientButton extends StatelessWidget {
  const AddIngredientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateMealController>(
      builder: (controller) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: controller.goToSelectFoodsPage,
          child: const Text('Add Ingredient'),
        ),
      ),
    );
  }
}
