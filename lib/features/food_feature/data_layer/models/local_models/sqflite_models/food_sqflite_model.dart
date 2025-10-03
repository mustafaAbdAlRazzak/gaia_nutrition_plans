class FoodSqfliteModel {
  int? id;
  String name;
  double protein;
  double fat;
  double carbohydrate;
  double calories;

  FoodSqfliteModel({
    this.id,
    required this.name,
    required this.protein,
    required this.fat,
    required this.carbohydrate,
    required this.calories,
  });

  factory FoodSqfliteModel.fromMap(Map<String, dynamic> map) {
    return FoodSqfliteModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      protein: (map['protein'] as num).toDouble(),
      fat: (map['fat'] as num).toDouble(),
      carbohydrate: (map['carbohydrate'] as num).toDouble(),
      calories: (map['calories'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      'name': name,
      'protein': protein,
      'fat': fat,
      'carbohydrate': carbohydrate,
      'calories': calories,
    };
    return map;
  }
}
