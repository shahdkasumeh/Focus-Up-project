// class TableModel {
//   final int id;
//   final int tableNum;
//   final bool isActive;
//   final bool isOccupied;
//   final int roomId;

//   TableModel({
//     required this.id,
//     required this.tableNum,
//     required this.isActive,
//     required this.isOccupied,
//     required this.roomId,
//   });

//   factory TableModel.fromJson(Map<String, dynamic> json) {
//     return TableModel(
//       id: json["id"] ?? 0,
//       tableNum: json["table_num"] ?? 0,
//       isActive: json["is_active"] == 1,
//       isOccupied: json["is_occupied"] == 1,
//       roomId: json["room_id"] ?? 0,
//     );
//   }
// }
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
      id: _toInt(json["id"]),
      tableNum: _toInt(json["table_num"]),
      isActive: _toBool(json["is_active"]),
      isOccupied: _toBool(json["is_occupied"]),
      roomId: _toInt(json["room_id"]),
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static bool _toBool(dynamic value) {
    if (value == null) return false;

    if (value is bool) return value;

    if (value is int) return value == 1;

    if (value is String) {
      return value == "1" || value.toLowerCase() == "true";
    }

    return false;
  }
}