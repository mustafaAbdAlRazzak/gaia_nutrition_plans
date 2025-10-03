class SqfliteMealIngredientModel {
  final int? id;
  final int mealId;
  final double weight;
  final int foodId;

  SqfliteMealIngredientModel({
    this.id,
    required this.mealId,
    required this.weight,
    required this.foodId,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'mealId': mealId, 'weight': weight, 'foodId': foodId};
  }

  factory SqfliteMealIngredientModel.fromMap(Map<String, dynamic> map) {
    return SqfliteMealIngredientModel(
      id: map['id'],
      mealId: map['mealId'],
      weight: map['weight'],
      foodId: map['foodId'],
    );
  }
}
