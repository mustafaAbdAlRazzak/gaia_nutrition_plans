class UserEntity {
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

  const UserEntity({
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
}
