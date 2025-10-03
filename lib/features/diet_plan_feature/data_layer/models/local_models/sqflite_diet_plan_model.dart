class SqfliteDietPlanModel {
  final int? id;
  final String name;
  final String description;

  SqfliteDietPlanModel({
    this.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'description': description};
  }

  factory SqfliteDietPlanModel.fromMap(Map<String, dynamic> map) {
    return SqfliteDietPlanModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }
}
