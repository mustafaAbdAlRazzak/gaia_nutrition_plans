class MealEntity {
  final int? id;
  final int? dietPlanId;
  final String name;
  final String description;

  MealEntity({
    this.id,
    this.dietPlanId,
    required this.name,
    required this.description,
  });
}
