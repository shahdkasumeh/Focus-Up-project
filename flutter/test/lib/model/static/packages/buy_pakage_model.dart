class BuyPackageModel {
  final int id;
  final String status;

  final double totalHours;
  final double remainingHours;
  final double usedHours;

  final double totalPrice;    
  final double remainingPrice;            

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

      totalHours: double.tryParse(json['total_hours'].toString()) ?? 0.0,
      remainingHours:
          double.tryParse(json['remaining_hours'].toString()) ?? 0.0,
      usedHours: double.tryParse(json['used_hours']?.toString() ?? '0') ?? 0.0,

      totalPrice: double.tryParse(json['total_price'].toString()) ?? 0.0,
      remainingPrice:
          double.tryParse(json['remaining_price'].toString()) ?? 0.0,

      startsAt: json['starts_at']?.toString() ?? '',
      expiresAt: json['expires_at']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
    );
  }
}
