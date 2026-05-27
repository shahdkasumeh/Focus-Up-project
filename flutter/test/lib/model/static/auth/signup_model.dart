class SignupModel {
  final String fullName;
  final String email;
  final String password;
  final String password_confirmation;
  final String phone;

  SignupModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.password_confirmation,
    required this.phone,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      password_confirmation: json['password_confirmation'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "full_name": fullName,
      "email": email,
      "password": password,
      "password_confirmation": password_confirmation,
      "phone": phone,
    };
  }
}
