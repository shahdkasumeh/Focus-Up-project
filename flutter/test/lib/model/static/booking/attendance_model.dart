class AttendanceModel {
  final int id;
  final String status;
  final String actualStart;
  final String? actualEnd;
  final String? hours;
  final String? totalPrice;
  final String? discountPercent;
  final String? discountAmount;

  AttendanceModel({
    required this.id,
    required this.status,
    required this.actualStart,
    this.actualEnd,
    this.hours,
    this.totalPrice,
    this.discountPercent,
    this.discountAmount,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(
      id: json["id"] ?? 0,
      status: json["status"] ?? "",
      actualStart: json["actual_start"] ?? "",
      actualEnd: json["actual_end"],
      hours: json["hours"]?.toString(),
      totalPrice: json["total_price"]?.toString(),
      discountPercent: json["discount_percent"]?.toString(),
      discountAmount: json["discount_amount"]?.toString(),
    );
  }
}