class ProfileModel {
  final int id;
  final String image;
  final String address;
  final String birthDate;
  final String gender;
  final String studyLevel;

  final String fullName;
  final String email;

  ProfileModel({
    required this.id,
    required this.image,
    required this.address,
    required this.birthDate,
    required this.gender,
    required this.studyLevel,
    required this.fullName,
    required this.email,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["id"] ?? 0,
      image: json["image"] ?? "",
      address: json["address"] ?? "",
      birthDate: json["birth_date"] ?? "",
      gender: json["gender"] ?? "",
      studyLevel: json["study_level"] ?? "",

      fullName: json["user"]?["fullname"] ?? "",
      email: json["user"]?["email"] ?? "",
    );
  }
}
