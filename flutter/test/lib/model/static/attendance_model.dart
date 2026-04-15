class AttendanceModel {
  final String status;
  final String actualStart;
  final String? actualEnd;
  final String? hours;
  final String? totalPrice;
  final String? discountPercent;
  final String? discountAmount;

  AttendanceModel({
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
