class MealIngredientEntity {
  final int? id;
  final int? mealId;
  final double weight;
  final int? foodId;

  MealIngredientEntity({
    this.id,
    this.mealId,
    required this.weight,
    this.foodId,
  });
}
