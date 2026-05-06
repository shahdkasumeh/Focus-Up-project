class BuyPackageModel {
  final int id;
  final String status;
  final int totalHours;
  final int remainingHours;
  final int usedHours;
  final int totalPrice;
  final int remainingPrice;
  final String startsAt;
  final String expiresAt;
  final String createdAt;

  BuyPackageModel({
    required this.id,
    required this.status,
    required this.totalHours,
    required this.remainingHours,
    required this.usedHours,
    required this.totalPrice,
    required this.remainingPrice,
    required this.startsAt,
    required this.expiresAt,
    required this.createdAt,
  });

  factory BuyPackageModel.fromJson(Map<String, dynamic> json) {
    return BuyPackageModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      status: json['status']?.toString() ?? '',
      totalHours: int.tryParse(json['total_hours'].toString()) ?? 0,
      remainingHours: int.tryParse(json['remaining_hours'].toString()) ?? 0,
      usedHours: int.tryParse(json['used_hours'].toString()) ?? 0,
      totalPrice: int.tryParse(json['total_price'].toString()) ?? 0,
      remainingPrice: int.tryParse(json['remaining_price'].toString()) ?? 0,
      startsAt: json['starts_at']?.toString() ?? '',
      expiresAt: json['expires_at']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}