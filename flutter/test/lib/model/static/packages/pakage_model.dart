class PackageModel {
  final int id;
  final String name;
  final int hours;
  final String price;
  final int durationDays;
  final String type;
  final int pricePerHour;

  PackageModel({
    required this.id,
    required this.name,
    required this.hours,
    required this.price,
    required this.durationDays,
    required this.type,
    required this.pricePerHour,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      hours: int.tryParse(json['hours'].toString()) ?? 0,
      price: json['price']?.toString() ?? '0',
      durationDays: int.tryParse(json['duration_days'].toString()) ?? 0,
      type: json['type']?.toString() ?? '',
      pricePerHour: int.tryParse(json['price_per_hour'].toString()) ?? 0,
    );
  }
}
