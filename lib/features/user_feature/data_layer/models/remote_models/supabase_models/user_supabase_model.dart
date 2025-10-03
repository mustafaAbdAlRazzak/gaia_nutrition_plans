class UserSupabaseModel {
  final String? id;
  final String firstName;
  final String? secondName;
  final DateTime birthday;
  final double weight;
  final double height;
  final bool gender;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserSupabaseModel({
    this.id,
    required this.firstName,
    this.secondName,
    required this.birthday,
    required this.weight,
    required this.height,
    required this.gender,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserSupabaseModel.fromSupabase(Map<String, dynamic> map) {
    return UserSupabaseModel(
      id: map['id'] as String?,
      firstName: map['first_name'] as String,
      secondName: map['second_name'] as String?,
      birthday: DateTime.parse(map['birthday'] as String),
      weight: (map['weight'] as num).toDouble(),
      height: (map['height'] as num).toDouble(),
      gender: map['gender'] as bool,
      email: map['email'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: DateTime.parse(map['updated_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'second_name': secondName,
      'birthday': birthday.toIso8601String(),
      'weight': weight,
      'height': height,
      'gender': gender,
      'email': email,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
