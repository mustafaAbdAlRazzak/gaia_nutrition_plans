import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/food_feature/domain_layer/entities/food_entity.dart';
import 'package:gaia_nutrition_plans/shared_widgets/food_nutrition_info.dart';

class FoodSearchItem extends StatelessWidget {
  final FoodEntity food;
  final bool isSelected;
  final VoidCallback onTap;

  const FoodSearchItem({
    super.key,
    required this.food,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(food.name, style: Theme.of(context).textTheme.titleMedium),
      subtitle: FoodNutritionInfo(
        calories: food.calories,
        protein: food.protein,
        fat: food.fat,
        carbohydrate: food.carbohydrate,
      ),
      trailing: Checkbox(value: isSelected, onChanged: (value) => onTap()),
    );
  }
}
