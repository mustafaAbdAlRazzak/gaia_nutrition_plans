import 'package:flutter/material.dart';
import 'package:gaia_nutrition_plans/features/diet_plan_feature/domain_layer/entities/meal_entity.dart';

class MealsList extends StatelessWidget {
  final List<MealEntity> meals;
  final Function(MealEntity) onEditMeal;
  final Function(MealEntity) onDeleteMeal;

  const MealsList({
    super.key,
    required this.meals,
    required this.onEditMeal,
    required this.onDeleteMeal,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return ListTile(
          onTap: () => onEditMeal(meal),
          title: Text(meal.name),
          trailing: PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'edit',
                onTap: () => onEditMeal(meal),
                child: const Text('Edit'),
              ),
              PopupMenuItem<String>(
                onTap: () => onDeleteMeal(meal),
                value: 'delete',
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }
}
