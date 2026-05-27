class TableModel {
  final int id;
  final int tableNum;
  final bool isActive;
  final bool isOccupied;
  final int roomId;

  TableModel({
    required this.id,
    required this.tableNum,
    required this.isActive,
    required this.isOccupied,
    required this.roomId,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json["id"] ?? 0,
      tableNum: json["table_num"] ?? 0,
      isActive: json["is_active"] == 1,
      isOccupied: json["is_occupied"] == 1,
      roomId: json["room_id"] ?? 0,
    );
  }
}
