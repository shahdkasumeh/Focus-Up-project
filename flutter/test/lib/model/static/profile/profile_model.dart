class ProfileModel {
  final int id;
  final String image;
  final String address;
  final String birthDate;
  final String gender;
  final String studyLevel;
  final int hasDiscount;
  final int userId;
  final String fullName;
  final String email;

  ProfileModel({
    required this.id,
    required this.image,
    required this.address,
    required this.birthDate,
    required this.gender,
    required this.studyLevel,
    required this.hasDiscount,
    required this.userId,
    required this.fullName,
    required this.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    return ProfileModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      image: json['image']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      birthDate: json['birth_date']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      studyLevel: json['study_level']?.toString() ?? '',
      hasDiscount: int.tryParse(json['has_discount'].toString()) ?? 0,
      userId: int.tryParse(user?['id']?.toString() ?? '0') ?? 0,
      fullName: user?['fullname']?.toString() ??
          user?['full_name']?.toString() ??
          '',
      email: user?['email']?.toString() ?? '',
    );
  }
}