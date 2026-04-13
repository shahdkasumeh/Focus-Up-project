class UserModel {
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final String roleType;
  final String status;
  final String? emailVerifiedAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.roleType,
    required this.status,
    this.emailVerifiedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? 0,
      fullName: json["full_name"] ?? "",
      email: json["email"] ?? "",
      phone: json["phone"] ?? "",
      roleType: json["role_type"] ?? "",
      status: json["status"] ?? "",
      emailVerifiedAt: json["email_verified_at"],
    );
  }
}
