class BookingModel {
  final int id;
  final String status;
  final String? scheduledStart;
  final String? scheduledEnd;
  final String? actualStart;
  final String? actualEnd;
  final double? hours;
  final double? totalPrice;
  final int? tableId;

  BookingModel({
    required this.id,
    required this.status,
    this.scheduledStart,
    this.scheduledEnd,
    this.actualStart,
    this.actualEnd,
    this.hours,
    this.totalPrice,
    this.tableId,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return BookingModel(
      id: data['id'],
      status: data['status'],
      scheduledStart: data['scheduled_start'],
      scheduledEnd: data['scheduled_end'],
      actualStart: data['actual_start'],
      actualEnd: data['actual_end'],
      hours: data['hours'] != null ? (data['hours'] as num).toDouble() : null,
      totalPrice: data['total_price'] != null
          ? (data['total_price'] as num).toDouble()
          : null,
      tableId: data['table'] != null ? data['table']['id'] : null,
    );
  }
}
