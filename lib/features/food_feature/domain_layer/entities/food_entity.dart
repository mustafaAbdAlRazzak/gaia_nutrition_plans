class FoodEntity {
  int? id;
  String name;
  double protein;
  double fat;
  double carbohydrate;
  double calories;
  FoodEntity({
    this.id,
    required this.name,
    required this.protein,
    required this.fat,
    required this.carbohydrate,
    required this.calories,
  });
}
