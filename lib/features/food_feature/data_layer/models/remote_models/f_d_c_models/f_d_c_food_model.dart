class FDCFoodModel {
  final int? id;
  final String name;
  final double protein;
  final double fat;
  final double carbohydrate;
  final double calories;

  FDCFoodModel({
    this.id,
    required this.name,
    required this.protein,
    required this.fat,
    required this.carbohydrate,
    required this.calories,
  });

  factory FDCFoodModel.fromJson(Map<String, dynamic> json) {
    final nutrients = json['foodNutrients'] as List<dynamic>? ?? [];

    double getNutrient(String nutrientName) {
      final nutrient = nutrients.firstWhere(
        (n) => n['nutrientName']?.toLowerCase() == nutrientName.toLowerCase(),
        orElse: () => null,
      );
      return nutrient != null ? (nutrient['value'] ?? 0.0).toDouble() : 0.0;
    }

    return FDCFoodModel(
      id: json['fdcId'],
      name: json['description'] ?? '',
      protein: getNutrient('Protein'),
      fat: getNutrient('Total lipid (fat)'),
      carbohydrate: getNutrient('Carbohydrate, by difference'),
      calories: getNutrient('Energy'),
    );
  }
}
