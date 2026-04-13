class BookingResponse {
  final BookingModel data;
  final String message;

  BookingResponse({required this.data, required this.message});

  factory BookingResponse.fromJson(Map<String, dynamic> json) {
    return BookingResponse(
      data: BookingModel.fromJson(json["data"]),
      message: json["message"] ?? "",
    );
  }
}

class BookingModel {
  final int id;
  final String status;
  final String action;
  final String? actualStart;
  final String? actualEnd;
  final double? hours;
  final double? totalPrice;
  final TableModel table;

  BookingModel({
    required this.id,
    required this.status,
    required this.action,
    this.actualStart,
    this.actualEnd,
    this.hours,
    this.totalPrice,
    required this.table,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json["id"] ?? 0,
      status: json["status"] ?? "",
      action: json["action"] ?? "",
      actualStart: json["actual_start"],
      actualEnd: json["actual_end"],
      hours: json["hours"] != null
          ? double.tryParse(json["hours"].toString())
          : null,
      totalPrice: json["total_price"] != null
          ? double.tryParse(json["total_price"].toString())
          : null,
      table: TableModel.fromJson(json["table"]),
    );
  }
}

class TableModel {
  final int id;
  final int tableNum;
  final bool isOccupied;

  TableModel({
    required this.id,
    required this.tableNum,
    required this.isOccupied,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json["id"] ?? 0,
      tableNum: json["table_num"] ?? 0,
      isOccupied: json["is_occupied"] == 1,
    );
  }
}
