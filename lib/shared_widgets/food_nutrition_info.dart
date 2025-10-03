import 'package:flutter/material.dart';

class FoodNutritionInfo extends StatelessWidget {
  final double calories;
  final double protein;
  final double fat;
  final double carbohydrate;

  const FoodNutritionInfo({
    super.key,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbohydrate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NutritionInfoItem(title: 'Calories:', value: calories, unit: 'kcal'),
        NutritionInfoItem(title: 'Protein:', value: protein, unit: 'g'),
        NutritionInfoItem(title: 'Fat:', value: fat, unit: 'g'),
        NutritionInfoItem(
          title: 'Carbohydrate:',
          value: carbohydrate,
          unit: 'g',
        ),
      ],
    );
  }
}

class NutritionInfoItem extends StatelessWidget {
  final String title;
  final double value;
  final String unit;

  const NutritionInfoItem({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: '${value.round()} $unit',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
