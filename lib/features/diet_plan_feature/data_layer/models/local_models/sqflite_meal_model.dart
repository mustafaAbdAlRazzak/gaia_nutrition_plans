class SqfliteMealModel {
  final int? id;
  final int dietPlanId;
  final String name;
  final String description;

  SqfliteMealModel({
    this.id,
    required this.dietPlanId,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dietPlanId': dietPlanId,
      'name': name,
      'description': description,
    };
  }

  factory SqfliteMealModel.fromMap(Map<String, dynamic> map) {
    return SqfliteMealModel(
      id: map['id'],
      dietPlanId: map['dietPlanId'],
      name: map['name'],
      description: map['description'],
    );
  }
}
